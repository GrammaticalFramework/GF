
# checking that a file is haddocky:
#   - checking if it has an export list
#   - checking that all exported functions have type signatures
#   - checking that the module header is OK

# changes on files:
#   - transforming hard space to ordinary space

# limitations:
#   - there might be some problems with nested comments
#   - cannot handle type signatures for several functions
#     (i.e. "a, b, c :: t")
#     but on the other hand -- haddock has some problems with these too...

$operSym = qr/[\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~\:]+/;
$funSym = qr/[a-z]\w*\'*/;

sub check_headerline {
  my ($title, $regexp) = @_;
  if (s/^-- $title *: +(.+?) *\n//s) {
    $name = $1;
    print "   > Incorrect ".lcfirst $title.": $name\n" unless $name =~ $regexp;
  } else {
    print "   > Header missing".lcfirst $title."\n";
  }
}


for $file (@ARGV) {
  $file =~ s/\.hs//;

  open F, "<$file.hs";
  $_ = join "", <F>;
  close F;

  print "-- $file\n";

  # substituting hard spaces for ordinary spaces
  $nchars = tr/\240/ /;
  if ($nchars > 0) {
    print "   ! Substituted $nchars hard spaces\n";
    open F, ">$file.hs";
    print F $_;
    close F;
  }

  # the module header
  s/^(--+\s*\n)+//s;
  unless (s/^-- \|\s*\n//s) {
    print "   > Incorrect module header\n";
  } else {
    &check_headerline("Module", qr/^[A-Z]\w*$/);
    &check_headerline("Maintainer", qr/^[\wåäöÅÄÖüÜ\s\@\.]+$/);
    &check_headerline("Stability", qr/.*/);
    &check_headerline("Portability", qr/.*/);
    s/^(--+\s*\n)+//s;
    print "   > Missing CVS information\n" unless s/^(-- > CVS +\$.*?\$ *\n)+//s;
    s/^(--+\s*\n)+//s;
    print "   > Missing module description\n" unless /^-- +[^\(]/;
  }

  # removing comments
  s/\{-.*?-\}//gs;
  s/--.*?\n/\n/g;

  # export list
  if (/\nmodule\s+(\w+)\s+\((.*?)\)\s+where/s) {
    ($module, $exportlist) = ($1, $2);

    # removing modules from exportlist
    $exportlist =~ s/module\s+[A-Z]\w*//gs;

    # type signatures
    while (/\n($funSym)\s*::/gs) {
      $function = $1;
      # print "- $function\n";
      $exportlist =~ s/\b$function\b//;
    }

    while (/\n(\($operSym\))\s*::/gs) {
      $function = $1;
      # print ": $function\n";
      $exportlist =~ s/\Q$function\E//;
    }

    # exported functions without type signatures
    while ($exportlist =~ /(\b$funSym\b|\($operSym\))/gs) {
      $function = $1;
      # print "+ $function\n";
      next if $function =~ /^[A-Z]/;
      next if $function =~ /^\((\.\.|\:\:?|\=|\\|\||\<\-|\-\>|\@|\~|\=\>)\)$/;
      print "   > No type signature for function: $function\n";
    }

    # type aliases
    # while (/\ntype\s+(\w+)/gs) {
    #   $type = $1;
    #   next if $exportlist =~ /\b$type\b/;
    #   printf "%-30s | Type alias not in export list: %s\n", $file, $type;
    # }

  } else {
    # modules without export lists
    print "   > No export list\n";
  }

}


