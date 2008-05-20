
# checking that a file is haddocky:
#   - checking if it has an export list
#   - if there is no export list, it tries to find all defined functions
#   - checking that all exported functions have type signatures
#   - checking that the module header is OK

# changes on files:
#   - transforming hard space to ordinary space

# limitations:
#   - there might be some problems with nested comments
#   - cannot handle type signatures for several functions
#     (i.e. "a, b, c :: t")
#     but on the other hand -- haddock has some problems with these too...

$operChar         =  qr/[\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~]/;
$operCharColon    =  qr/[\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~\:]/;
$nonOperChar      = qr/[^\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~]/;
$nonOperCharColon = qr/[^\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~\:]/;

$operSym = qr/$operChar $operCharColon*/x;
$funSym = qr/[a-z] \w* \'*/x;
$funOrOper = qr/(?: $funSym | \($operSym\) )/x;

$keyword = qr/(?: type | data | module | newtype | infix[lr]? | import | instance | class )/x;
$keyOper = qr/^(?: \.\. | \:\:? | \= | \\ | \| | \<\- | \-\> | \@ | \~ | \=\> | \. )$/x;

sub check_headerline {
  my ($title, $regexp) = @_;
  if (s/^-- \s $title \s* : \s+ (.+?) \s*\n//sx) {
    $name = $1;
    push @ERR, "Incorrect ".lcfirst $title.": $name"
      unless $name =~ $regexp;
    return $&;
  } else {
    push @ERR, "Header missing: ".lcfirst $title."";
  }
}

if ($#ARGV >= 0) {
  @FILES = @ARGV;
} else {
#   @dirs = qw{. api canonical cf cfgm compile for-ghc-nofud
# 	     grammar infra notrace parsers shell
# 	     source speech translate useGrammar util visualization
# 	     GF GF/* GF/*/* GF/*/*/*};
  @dirs = qw{GF GF/* GF/*/* GF/*/*/*};
  @FILES = grep(!/\/(Par|Lex)(GF|GFC|CFG)\.hs$/,
		glob "{".join(",",@dirs)."}/*.hs");
}

for $file (@FILES) {
  $file =~ s/\.hs//;

  open F, "<$file.hs";
  $_ = join "", <F>;
  close F;

  @ERR = ();

  # substituting hard spaces for ordinary spaces
  $nchars = tr/\240/ /;
  if ($nchars > 0) {
    push @ERR, "!! > Substituted $nchars hard spaces";
    open F, ">$file.hs";
    print F $_;
    close F;
  }

  # the module header
  $hdr_module = $module = "";

  s/^ \{-\# \s+ OPTIONS \s+ -cpp \s+ \#-\} //sx;  # removing ghc options (cpp)
  s/^ \s+ //sx;  # removing initial whitespace
  s/^ (--+ \s* \n) +//sx;  # removing initial comment lines
  unless (s/^ -- \s \| \s* \n//sx) {
    push @ERR, "Incorrect module header";
  } else {
    $hdr_module = s/^-- \s Module \s* : \s+ (.+?) \s*\n//sx ? $1 : "";
    &check_headerline("Maintainer", qr/^ [\wåäöÅÄÖüÜ\s\@\.]+ $/x);
    &check_headerline("Stability", qr/.*/);
    &check_headerline("Portability", qr/.*/);
    s/^ (--+ \s* \n) +//sx;
    push @ERR, "Missing CVS information"
      unless s/^(-- \s+ \> \s+ CVS \s+ \$ .*? \$ \s* \n)+//sx;
    s/^ (--+ \s* \n) +//sx;
    push @ERR, "Missing module description"
      unless /^ -- \s+ [^\(]/x;
  }

  # removing comments
  s/\{- .*? -\}//gsx;
  s/-- ($nonOperSymColon .*? \n | \n)/\n/gx;

  # removing \n in front of whitespace (for simplification)
  s/\n+[ \t]/ /gs;

  # the export list
  $exportlist = "";

  if (/\n module \s+ ((?: \w | \.)+) \s+ \( (.*?) \) \s+ where/sx) {
    ($module, $exportlist) = ($1, $2);

    $exportlist =~ s/\b module \s+ [A-Z] \w*//gsx;
    $exportlist =~ s/\(\.\.\)//g;

  } elsif (/\n module \s+ ((?: \w | \.)+) \s+ where/sx) {
    $module = $1;

    # modules without export lists
    # push @ERR, "No export list";

    # function definitions
    while (/^ (.*? $nonOperCharColon) = (?! $operCharColon)/gmx) {
      $defn = $1;
      next if $defn =~ /^ $keyword \b/x;

      if ($defn =~ /\` ($funSym) \`/x) {
	$fn = $1;
      } elsif ($defn =~ /(?<! $operCharColon) ($operSym)/x
	       && $1 !~ $keyOper) {
	$fn = "($1)";
      } elsif ($defn =~ /^($funSym)/x) {
	$fn = $1;
      } else {
	push @ERR, "!! > Error in function defintion: $defn";
	next;
      }

      $exportlist .= " $fn ";
    }
  } else {
    push @ERR, "No module header found";
  }

  push @ERR, "Module names not matching: $module != $hdr_module"
    if $hdr_module && $module !~ /\Q$hdr_module\E$/;

  # fixing exportlist (double spaces as separator)
  $exportlist = " $exportlist ";
  $exportlist =~ s/(\s | \,)+/  /gx;

  # removing functions with type signatures from export list
  while (/^ ($funOrOper (\s* , \s* $funOrOper)*) \s* ::/gmx) {
    $functionlist = $1;
    while ($functionlist =~ s/^ ($funOrOper) (\s* , \s*)?//x) {
      $function = $1;
      $exportlist =~ s/\s \Q$function\E \s/ /gx;
    }
  }

  # reporting exported functions without type signatures
  $reported = 0;
  $untyped = "";
  while ($exportlist =~ /\s ($funOrOper) \s/x) {
    $function = $1;
    $exportlist =~ s/\s \Q$function\E \s/ /gx;
    $reported++;
    $untyped .= " $function";
  }
  push @ERR, "No type signature for $reported function(s):\n    " . $untyped
    if $reported;

  print "-- $file\n   > " . join("\n   > ", @ERR) . "\n"
    if @ERR;
}


