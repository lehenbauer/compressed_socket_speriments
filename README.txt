


this tests adding channel compression to an existing channel

you run ./server85.tcl on a tcl85-equipped machine

in another terminal window you run ./client85.tcl

you type stuff into the client and it appears on the server

when you type a line that says "compress" and hit enter then it should add compression to both sides

./server86.tcl tries to do the same thing only by pushing zlib decompression onto the channel

neither one work at the moment

UPDATE

turns out it does work once you send "compress" but only upon EOF does it send stuff.  So there needs to be a way to flush the zlib stack or whatever, if that's possible.
