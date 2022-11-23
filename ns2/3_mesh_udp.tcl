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
set n5 [$ns node]


$ns duplex-link $n0 $n1 5Mb 15ms DropTail
$ns duplex-link $n0 $n2 5Mb 15ms DropTail
$ns duplex-link $n0 $n3 5Mb 15ms DropTail
$ns duplex-link $n0 $n4 5Mb 15ms DropTail
$ns duplex-link $n0 $n5 5Mb 15ms DropTail
$ns duplex-link $n1 $n2 5Mb 15ms DropTail
$ns duplex-link $n1 $n3 5Mb 15ms DropTail
$ns duplex-link $n1 $n4 5Mb 15ms DropTail
$ns duplex-link $n1 $n5 5Mb 15ms DropTail
$ns duplex-link $n2 $n3 5Mb 15ms DropTail
$ns duplex-link $n2 $n4 5Mb 15ms DropTail
$ns duplex-link $n2 $n5 5Mb 15ms DropTail
$ns duplex-link $n3 $n4 5Mb 15ms DropTail
$ns duplex-link $n3 $n4 5Mb 15ms DropTail
$ns duplex-link $n3 $n5 5Mb 15ms DropTail
$ns duplex-link $n4 $n5 5Mb 15ms DropTail
$ns duplex-link $n5 $n0 5Mb 15ms DropTail




$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n3 $n4 orient left
$ns duplex-link-op $n4 $n5 orient left-up
$ns duplex-link-op $n5 $n0 orient right-up




set udp [new Agent/UDP]
$udp set class_ 2
$ns attach-agent $n2 $udp
set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp $null
$udp set fid_ 1


set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000

set udp1 [new Agent/UDP]
$udp1 set class_ 3
$ns attach-agent $n1 $udp1
set null1 [new Agent/Null]
$ns attach-agent $n5 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 2

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packet_size_ 1000

$ns at 0.01 "$cbr start"
$ns at 5.0 "$cbr stop"
$ns at 0.01 "$cbr1 start"
$ns at 5.0 "$cbr1 stop"


$ns at 6.0 "finish"

$ns run