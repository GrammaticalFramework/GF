#!/bin/sh

echo "abstract DictRusAbs = Cat ** {
"
cat $1 | sed 's/^lin/fun/g;s/=.*$//g;s/\_N/\_N : N\;/g;s/\_PN/\_PN : PN\;/g;s/\_A /\_A : A\;/g;s/\_V/\_V : V\;/g;s/\_Adv/\_Adv : Adv\;/g'

echo "
}"