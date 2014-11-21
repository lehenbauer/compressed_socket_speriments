#!/usr/local/bin/tclsh8.5


package require Trf

proc setup {} {
    set sock [socket localhost 1337]
    set ::leetsock $sock
    fconfigure $sock -translation binary -encoding binary -blocking 0 -buffering line

    fconfigure stdin -blocking 0
    fileevent stdin readable [list stdin_data_available]
}

proc stdin_data_available {} {
    if {[eof stdin]} {
	puts "EOF from stdin"
	exit
    }

    if {[gets stdin line] < 0} {
	return
    }

    puts "got from stdin: $line"
    puts $::leetsock $line

    if {$line == "compress"} {
	puts "enabling compression on channel..."
	zip -attach $::leetsock -mode compress -nowrap 0
    }
}

proc main {{argv ""}} {
    setup

    vwait die
}


if {!$tcl_interactive} {
    main $argv
}
