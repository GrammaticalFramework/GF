
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

$keyword = qr/(?: type | data | module | newtype | infix[lr]? | import | instance | class )/x;
$keyOper = qr/^( ?: \.\. | \:\:? | \= | \\ | \| | \<\- | \-\> | \@ | \~ | \=\> | \. )$/x;

sub check_headerline {
  my ($title, $regexp) = @_;
  if (s/^-- \s $title \s* : \s+ (.+?) \s*\n//sx) {
    $name = $1;
    print "   > Incorrect ".lcfirst $title.": $name\n" unless $name =~ $regexp;
  } else {
    print "   > Header missing".lcfirst $title."\n";
  }
}

if ($#ARGV >= 0) {
  @FILES = @ARGV;
} else {
  @dirs = qw/. api canonical cf cfgm compile for-ghc-nofud
	     grammar infra newparsing notrace parsers shell
	     source speech translate useGrammar util visualization/;
  @FILES = grep(!/\/(Par|Lex)(GF|GFC|CFG)\.hs$/,
		glob "{".join(",",@dirs)."}/*.hs");
}

for $file (@FILES) {
  $file =~ s/\.hs//;

  open F, "<$file.hs";
  $_ = join "", <F>;
  close F;

  print "-- $file\n";

  # substituting hard spaces for ordinary spaces
  $nchars = tr/\240/ /;
  if ($nchars > 0) {
    print "!! > Substituted $nchars hard spaces\n";
    open F, ">$file.hs";
    print F $_;
    close F;
  }

  # the module header
  s/^ (--+ \s* \n) +//sx;
  unless (s/^ -- \s \| \s* \n//sx) {
    print "   > Incorrect module header\n";
  } else {
    &check_headerline("Module", qr/^ [A-Z] \w* $/x);
    &check_headerline("Maintainer", qr/^ [\wåäöÅÄÖüÜ\s\@\.]+ $/x);
    &check_headerline("Stability", qr/.*/);
    &check_headerline("Portability", qr/.*/);
    s/^ (--+ \s* \n) +//sx;
    print "   > Missing CVS information\n"
      unless s/^(-- \s+ \> \s+ CVS \s+ \$ .*? \$ \s* \n)+//sx;
    s/^ (--+ \s* \n) +//sx;
    print "   > Missing module description\n" 
      unless /^ -- \s+ [^\(]/x;
  }

  # removing comments
  s/\{- .*? -\}//gsx;
  s/-- ($nonOperSymColon .*? \n | \n)/\n/gx;

  # removing \n in front of whitespace (for simplification)
  s/\n+[ \t]/ /gs;

  # the export list
  $exportlist = "";

  if (/\n module \s+ (\w+) \s+ \( (.*?) \) \s+ where/sx) {
    ($module, $exportlist) = ($1, $2);

    $exportlist =~ s/\b module \s+ [A-Z] \w*//gsx;
    $exportlist =~ s/\(\.\.\)//g;

  } else {
    # modules without export lists
    print "   > No export list\n";

    # function definitions
    while (/^ (.*? $nonOperCharColon) = (?!$operCharColon)/gmx) {
      $defn = $1;
      next if $defn =~ /^ $keyword \b/x;

      if ($defn =~ /\` ($funSym) \`/x) {
	$fn = $1;
      } elsif ($defn =~ /(?<!$operCharColon) ($operSym)/x
	       && $1 !~ $keyOper) {
	$fn = "($1)";
      } elsif ($defn =~ /^($funSym)/x) {
	$fn = $1;
      } else {
	print "!! > Error in function defintion: $defn\n";
	next;
      }

      $exportlist .= " $fn ";
    }
  }

  # removing from export list...

  # ...ordinary functions
  while (/^ ($funSym) \s* ::/gmx) {
    $function = $1;
    $exportlist =~ s/\b $function \b//gx;
  }

  # ...operations
  while (/^ (\( $operSym \)) \s* ::/gmx) {
    $function = $1;
    $exportlist =~ s/\Q$function\E//g;
  }

  # reporting exported functions without type signatures
  $reported = 0;
  while ($exportlist =~ /(\b $funSym \b | \( $operSym \))/gx) {
    $function = $1;
    print "   > No type signature for function(s):"
      unless $reported;
    print "\n    " unless $reported++ % 5;
    print " $function";
  }
  print "\n     ($reported functions)\n"
    if $reported;

}


