# Create simulator
set ns [new Simulator]

# Trace and NAM file setup
set tracefile [open dos_trace.tr w]
$ns trace-all $tracefile

set namfile [open dos_attack.nam w]
$ns namtrace-all $namfile

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam dos_attack.nam &
    exit 0
}

# -----------------------------
# Node creation
# -----------------------------
set client1 [$ns node]
set client2 [$ns node]
set attacker [$ns node]
set server1 [$ns node]
set server2 [$ns node]

# -----------------------------
# Create links
# -----------------------------
$ns duplex-link $client1 $server1 5Mb 2ms DropTail
$ns duplex-link $client2 $server2 5Mb 2ms DropTail
$ns duplex-link $attacker $server1 5Mb 2ms DropTail

# -----------------------------
# Create Agents (UDP)
# -----------------------------
# Client 1 → Server 1
set udp1 [new Agent/UDP]
$ns attach-agent $client1 $udp1
set null1 [new Agent/Null]
$ns attach-agent $server1 $null1
$ns connect $udp1 $null1

# Client 2 → Server 2
set udp2 [new Agent/UDP]
$ns attach-agent $client2 $udp2
set null2 [new Agent/Null]
$ns attach-agent $server2 $null2
$ns connect $udp2 $null2

# Attacker → Server 1 (targeted DoS)
set udp3 [new Agent/UDP]
$ns attach-agent $attacker $udp3
set null3 [new Agent/Null]
$ns attach-agent $server1 $null3
$ns connect $udp3 $null3

# -----------------------------
# Application Traffic (CBR)
# -----------------------------
# Normal traffic: Client 1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 512
$cbr1 set interval_ 0.5
$cbr1 attach-agent $udp1

# Normal traffic: Client 2
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 512
$cbr2 set interval_ 0.5
$cbr2 attach-agent $udp2

# DoS attack traffic: Attacker (high-rate CBR)
set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 1024
$cbr3 set interval_ 0.0001 ;# very high rate (DoS)
$cbr3 attach-agent $udp3

# -----------------------------
# Schedule traffic
# -----------------------------
# Normal traffic
$ns at 0.5 "$cbr1 start"
$ns at 0.6 "$cbr2 start"

# DoS attacker starts a bit later
$ns at 1.0 "$cbr3 start"

# Stop all traffic after some time
$ns at 5.0 "$cbr1 stop"
$ns at 5.0 "$cbr2 stop"
$ns at 5.0 "$cbr3 stop"

# End simulation
$ns at 5.1 "finish"

# Run simulation
$ns run

