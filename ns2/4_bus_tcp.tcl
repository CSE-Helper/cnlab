set ns [new Simulator]
$ns color 1 Blue
set nf [open out.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$ns duplex-link $n1 $n2 12Mb 10ms DropTail

$ns duplex-link-op $n1 $n2 orient up

set lan [ $ns newLan "$n0 $n1 $n2 $n3 $n4" 12Mb 10ms LL Queue/DropTail MAC/-802_3 channel ]

set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n2 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 1000
$ftp set interval_ 0.001s
$ns at 0.01 "$ftp start"
$ns at 5.0 "$ftp stop"

$ns at 5.0 "finish"
$ns run
