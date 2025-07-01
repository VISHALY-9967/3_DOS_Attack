<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>

  <h1>🛰️ NS2 Network Simulation Project</h1>

  <p>This repository contains basic simulations using the Network Simulator 2 (NS2) and NAM (Network Animator). It includes three Tcl scripts that demonstrate:</p>
  <ul>
    <li>Basic UDP communication</li>
    <li>TCP connection simulation</li>
    <li>UDP-based Denial of Service (DoS) attack scenario</li>
  </ul>

  <h2>📂 Files Included</h2>
  <ul>
    <li><strong>UDP.tcl</strong> - Basic UDP client-server simulation</li>
    <li><strong>TCP.tcl</strong> - Basic TCP client-server communication using FTP</li>
    <li><strong>DOS.tcl</strong> - DoS attack scenario using high-rate UDP flood</li>
  </ul>

  <h2>🚀 How to Run</h2>
  <pre>
$ ns UDP.tcl
$ ns TCP.tcl
$ ns DOS.tcl
  </pre>
  <p>To view the animation:</p>
  <pre>
$ nam filename.nam
  </pre>

  <div class="file-section">
    <h2>📡 UDP.tcl</h2>
    <p>This script simulates a basic UDP connection between two nodes:</p>
    <ul>
      <li>One client sends CBR (Constant Bit Rate) traffic using a UDP agent</li>
      <li>The server uses a Null agent to receive traffic</li>
      <li>Packets are generated at regular intervals (0.5 seconds)</li>
    </ul>
    <p><strong>Key Components:</strong></p>
    <ul>
      <li><code>Agent/UDP</code> - Transport agent for sending</li>
      <li><code>Application/Traffic/CBR</code> - Constant traffic generation</li>
      <li>Trace and NAM output files are created</li>
    </ul>
  </div>

  <div class="file-section">
    <h2>🌐 TCP.tcl</h2>
    <p>This script demonstrates a simple TCP connection between a client and a server:</p>
    <ul>
      <li>Uses <code>Agent/TCP</code> and <code>Agent/TCPSink</code></li>
      <li>Traffic is generated using an FTP application over TCP</li>
      <li>More reliable and connection-oriented than UDP</li>
    </ul>
    <p><strong>Key Components:</strong></p>
    <ul>
      <li><code>Agent/TCP</code> - Connection-oriented transport</li>
      <li><code>Application/FTP</code> - Sends data over TCP</li>
      <li>Output files: <code>tcp_trace.tr</code> and <code>tcp_output.nam</code></li>
    </ul>
  </div>

  <div class="file-section">
    <h2>💣 DOS.tcl</h2>
    <p>This script simulates a basic DoS (Denial of Service) attack using UDP flood:</p>
    <ul>
      <li>2 clients send normal UDP traffic to 2 servers</li>
      <li>1 attacker node sends high-rate UDP traffic to Server 1</li>
      <li>Objective is to simulate a resource overload attack</li>
    </ul>
    <p><strong>Key Components:</strong></p>
    <ul>
      <li><code>Application/Traffic/CBR</code> with very low interval (0.0001) from attacker</li>
      <li><code>Agent/UDP</code> - Transport agents for both attacker and clients</li>
      <li>NAM shows visible overload on Server 1</li>
    </ul>
    <p><strong>Output files:</strong></p>
    <ul>
      <li><code>dos_trace.tr</code> - Trace file</li>
      <li><code>dos_attack.nam</code> - Animation file</li>
    </ul>
  </div>

  <h2>📊 Analysis (Optional)</h2>
  <p>You can analyze the trace files using <code>awk</code>, <code>grep</code>, or custom Python scripts to extract packet loss, delay, and throughput.</p>

  <h2>📌 Prerequisites</h2>
  <ul>
    <li>NS2 installed (v2.35 recommended)</li>
    <li>NAM installed for visual animation</li>
    <li>Linux environment (e.g., Kali, Ubuntu)</li>
  </ul>

  <h2>📧 Contact</h2>
  <p>If you have questions or want to collaborate, feel free to reach out or open an issue in the GitHub repository.</p>

</body>
</html>
