<?php 

$account_sid = 'ACea01d45a08264887f6bd17ea0d66d6fb'; 
$auth_token = '1a4944a8a693f0b22a8ab89e291613c8'; 
$twilio_number = '+15673612726'; // replace with your Twilio phone number
$to_number = $_POST['to']; 
$message = $_POST['message']; 

$data = array( 
    'From' => $twilio_number, 
    'To' => $to_number, 
    'Body' => $message, 
); 
$url = 'https://api.twilio.com/2010-04-01/Accounts/' . $account_sid . '/Messages'; 

$ch = curl_init(); 
curl_setopt($ch, CURLOPT_URL, $url); 
curl_setopt($ch, CURLOPT_POST, 1); 
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data)); 
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_USERPWD, $account_sid . ':' . $auth_token); 
$response = curl_exec($ch); 
curl_close($ch); 

echo $response;
