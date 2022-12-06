#Create a simulator object
set ns [new Simulator]
#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf
#Define a 'finish' procedure
proc finish {} {
global ns nf
$ns flush-trace
#Close the trace file
close $nf
#Executenam on the trace file
exec nam out.nam &
exit 0
}
#Create six nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
#Create links between the nodes
$ns duplex-link $n0 $n1 5Mbps 15ms DropTail
$ns duplex-link $n0 $n2 5Mbps 15ms DropTail
$ns duplex-link $n0 $n3 5Mbps 15ms DropTail
$ns duplex-link $n0 $n4 5Mbps 15ms DropTail
$ns duplex-link $n0 $n5 5Mbps 15ms DropTail
$ns duplex-link $n1 $n2 5Mbps 15ms DropTail
$ns duplex-link $n1 $n3 5Mbps 15ms DropTail
$ns duplex-link $n1 $n4 5Mbps 15ms DropTail
$ns duplex-link $n1 $n5 5Mbps 15ms DropTail
$ns duplex-link $n2 $n3 5Mbps 15ms DropTail
$ns duplex-link $n2 $n4 5Mbps 15ms DropTail
$ns duplex-link $n2 $n5 5Mbps 15ms DropTail
$ns duplex-link $n3 $n4 5Mbps 15ms DropTail
$ns duplex-link $n3 $n5 5Mbps 15ms DropTail
$ns duplex-link $n4 $n5 5Mbps 15ms DropTail
#Create a TCP agent and attach it to node n2 and node n1
set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $n5 $tcp1
$tcp1 set window_ 8
$tcp1 set fid_ 1
$tcp1 set class_ 1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
set tcp2 [new Agent/TCP/Reno]
$ns attach-agent $n0 $tcp2
$tcp2 set window_ 8
$tcp2 set fid_ 2
$tcp2 set class_ 2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n1 $sink2
$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ns at 0.01 "$ftp1 start"
$ns at 5 "$ftp1 stop"
$ns at 0.01 "$ftp2 start"
$ns at 5 "$ftp2 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5 "finish"
$ns run
