set ns [new Simulator]
set nr [open thro.tr w]
$ns trace-all $nr
set nf [open thro.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nr nf
$ns flush-trace
close $nf
close $nr
exec nam thro.nam &
exit 0
}
$ns color 1 Blue
$ns color 2 Red
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n0 $n5 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n3 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 5Mb 15ms DropTail
$ns duplex-link $n2 $n5 5Mb 15ms DropTail
$ns duplex-link $n3 $n4 5Mb 15ms DropTail
$ns duplex-link $n4 $n5 2Mb 10ms DropTail
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n0 $n5 orient left-up
$ns duplex-link-op $n1 $n2 orient left
$ns duplex-link-op $n1 $n3 orient right-up
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n2 $n5 orient left-up
$ns duplex-link-op $n3 $n4 orient left-up
$ns duplex-link-op $n4 $n5 orient left-down
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n1 $tcp
$tcp set fid_ 1
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 1000
$ftp set rate_ 100
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
set tcp1 [new Agent/TCP]
$tcp1 set class_ 3
$ns attach-agent $n0 $tcp1
$tcp1 set fid_ 2
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1000
$ftp1 set rate_ 100
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$ns rtproto LS
$ns rtmodel-at 10.0 down $n3 $n4
$ns rtmodel-at 15.0 down $n2 $n3
$ns rtmodel-at 30.0 up $n3 $n4
$ns rtmodel-at 20.0 up $n2 $n3
$ns color 1 Red
$ns color 2 Green
$ns at 1.0 "$ftp start"
$ns at 2.0 "$ftp1 start"
$ns at 5 "finish"
$ns run
$ns at 16.5 "finish"
$ns run

