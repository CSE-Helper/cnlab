set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

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


$ns duplex-link $n1 $n0 2Mb 10ms DropTail
$ns duplex-link $n2 $n0 2Mb 10ms DropTail
$ns duplex-link $n3 $n0 2Mb 10ms DropTail
$ns duplex-link $n4 $n0 2Mb 10ms DropTail




$ns duplex-link-op $n1 $n0 orient right-down
$ns duplex-link-op $n2 $n0 orient right-up
$ns duplex-link-op $n3 $n0 orient left-up
$ns duplex-link-op $n4 $n0 orient left-down



set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n2 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1


set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 1000
$ftp set interval_ 0.001s

set tcp1 [new Agent/TCP]
$tcp1 set class_ 3
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 2


set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1000
$ftp1 set interval_ 0.001s

$ns at 0.01 "$ftp start"
$ns at 15.0 "$ftp stop"
$ns at 0.02 "$ftp1 start"
$ns at 15.0 "$ftp1 stop"


$ns at 16.0 "$ns detach-agent $n2 $tcp ; $ns detach-agent $n4 $sink"
$ns at 16.0 "$ns detach-agent $n1 $tcp1 ; $ns detach-agent $n3 $sink"


$ns at 16.5 "finish"

$ns run