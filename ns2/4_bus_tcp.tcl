#Create a simulator object
set ns [new Simulator]
$ns color 1 Green

set tracefile [open ns-simple.tr w]
$ns trace-all $tracefile
#Open the nam trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

proc finish {} {
 global ns tracefile namfile
 $ns flush-trace
 close $tracefile
 close $namfile
 exec nam out.nam &
 exit 0
}
#Create two nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Create a duplex link between the nodes
$ns duplex-link $n0 $n1 100Mb 10ms DropTail
$ns queue-limit $n0 $n1 50

$ns duplex-link-op $n0 $n1 orient right

set lan [ $ns newLan "$n1 $n2 $n3 $n4 $n5" 12Mb 10ms LL Queue/DropTail MAC/-802_3 channel ]

#Create a TCP agent and attach it to node n2 and node n1
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1
$tcp1 set packetSize_ 500
$tcp1 set interval_ 0.01s

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ns at 0.01 "$ftp1 start"
$ns at 5.0 "$ftp1 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5 "finish"
$ns run