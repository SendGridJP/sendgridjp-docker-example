<?php
$url = 'http://sendgrid.com/';
$user = 'awwa500';
$pass = 'nishion123';

$json_string = array(

  'to' => array(
    'wataru@kke.co.jp', 'awwa500@gmail.com'
  ),
  'category' => 'test_category'
);


$params = array(
    'api_user'  => $user,
    'api_key'   => $pass,
    'x-smtpapi' => json_encode($json_string),
    'to'        => 'wataru@kke.co.jp',
    'subject'   => 'testing from curl',
    'html'      => 'testing body',
    'text'      => 'testing body',
    'from'      => 'wataru@kke.co.jp',
  );


$request =  $url.'api/mail.send.json';

// Generate curl request
$session = curl_init($request);
// Tell curl to use HTTP POST
curl_setopt ($session, CURLOPT_POST, true);
// Tell curl that this is the body of the POST
curl_setopt ($session, CURLOPT_POSTFIELDS, $params);
// Tell curl not to return headers, but do return the response
curl_setopt($session, CURLOPT_HEADER, false);
curl_setopt($session, CURLOPT_RETURNTRANSFER, true);

// obtain response
$response = curl_exec($session);
curl_close($session);

// print everything out
print_r($response);

