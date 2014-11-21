#
# this tests using trf to compress a file and then decompressing it
#
#

package require Trf

set ofp [open foo w]
fconfigure $ofp -translation binary
zip -attach $ofp -mode compress -nowrap 0
fconfigure $ofp -translation binary

puts $ofp "Beware the Jabberwock, my son!"
puts $ofp "  The jaws that bite, the claws that catch!"
puts $ofp "  Beware the Jubjub bird, and shun"
puts $ofp "    The frumious Bandersnatch!"
puts $ofp "    He took his vorpal sword in hand:"
puts $ofp "      Long time the manxome foe he sought --"
puts $ofp "      So rested he by the Tumtum tree,"
puts $ofp "        And stood awhile in thought."

flush $ofp
close $ofp

puts "closed, now opening..."

set fp [open foo r]
fconfigure $fp -translation binary
zip -attach $fp -mode compress -nowrap 0
#fconfigure $fp -translation binary

while {[gets $fp line] >= 0} {
    puts $line
}

close $fp
