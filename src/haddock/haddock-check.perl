
# checking that a file is haddocky

# limitations:
#   - does not check that 'type' declarations really are put in the export list
#   - there might be some problems with nested comments

for $file (@ARGV) {
  $file =~ s/\.hs//;

  open F, "<$file.hs";
  $_ = join "", <F>;
  close F;

  # print "- $file\n";

  # removing comments:
  s/\{-.*?-\}//gs;
  s/--.*?\n/\n/g;

  # export list:
  if (/\nmodule\s+(\w+)\s+\((.*?)\)\s+where/s) {
    ($module, $exportlist) = ($1, $2);

    # removing modules from exportlist:
    $exportlist =~ s/module\s+[A-Z]\w*//gs;

    # type signatures:
    while (/\n([a-z]\w*)\s*::/gs) {
      $function = $1;
      $exportlist =~ s/\b$function\b//;
    }

    while ($exportlist =~ /\b(\w+)\b/gs) {
      $function = $1;
      next if $function =~ /^[A-Z]/;
      printf "%-30s | No type signature for '%s'\n", $file, $1;
    }

  } else {
    printf "%-30s | No export list\n", $file;
  }

}


