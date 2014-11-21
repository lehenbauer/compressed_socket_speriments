#!/usr/local/bin/tclsh8.5

package require Trf

proc handle_connection {sock ip port} {
    puts "connect $sock from $ip $port"
    fconfigure $sock -translation binary -blocking 0 -buffering line
    fileevent $sock readable [list remote_data_available $sock]
}

proc remote_data_available {sock} {
    if {[eof $sock]} {
	puts "eof from sock $sock"
	close $sock
	return
    }

    if {[gets $sock line] < 0} {
	return
    }

    puts "got: $line"

    if {$line == "compress"} {
	puts "client side requested compression, enabling..."
	#zlib push decompress $sock
	zip -attach $sock -mode compress -nowrap 0
    }
}


proc main {{argv ""}} {
    socket -server handle_connection 1337

    vwait die
}

if {!$tcl_interactive} {
    main $argv
}
