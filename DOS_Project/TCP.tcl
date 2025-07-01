# Create a simulator
set ns [new Simulator]

# Create trace and NAM files with different names
set tracefile [open tcp_trace.tr w]
$ns trace-all $tracefile

set namfile [open tcp_output.nam w]
$ns namtrace-all $namfile

# Finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam tcp_output.nam &
    exit 0
}

# Node creation
set n1 [$ns node]
set n2 [$ns node]

# Connection between nodes
$ns duplex-link $n1 $n2 5Mb 2ms DropTail

# TCP Agent setup
set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink

$ns connect $tcp $sink

# FTP application to generate traffic over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Start and stop traffic
$ns at 0.1 "$ftp start"
$ns at 4.5 "$ftp stop"

# Call finish procedure
$ns at 5.0 "finish"

# Run the simulation
$ns run

