#Create a simulator object
set ns [new Simulator]
#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf
#Define a 'finish' procedure
#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
#Execute nam on the trace file
exec nam out.nam &
exit 0
}
#Create two nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
#Create a duplex link between the nodes
$ns duplex-link $n0 $n1 5Mb 10ms DropTail
$ns duplex-link $n1 $n2 5Mb 10ms DropTail
$ns duplex-link $n2 $n3 5Mb 10ms DropTail
$ns duplex-link $n3 $n4 5Mb 10ms DropTail
$ns duplex-link $n4 $n0 5Mb 10ms DropTail
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n1 $n2 orient down
$ns duplex-link-op $n2 $n3 orient left
$ns duplex-link-op $n3 $n4 orient up
$ns duplex-link-op $n4 $n0 orient right-up
#Create a TCP agent and attach it to node n2 and node n1
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
$tcp1 set window_ 8
$tcp1 set fid_ 1
$tcp1 set class_ 1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set rate 1000Mb
$ns at 0.01 "$ftp1 start"
$ns at 5 "$ftp1 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5 "finish"
$ns run
