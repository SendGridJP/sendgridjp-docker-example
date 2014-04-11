<?php

include 'SmtpApiHeader.php';

$hdr      = new SmtpApiHeader();
$receiver = array(
    'awwa500@gmail.com',
    'awwa501@gmail.com',
    'awwa502@gmail.com'
);
$times    = array(
    '1pm',
    '2pm',
    '3pm'
);
$names    = array(
    'kyle',
    'bob',
    'someguy'
);

$hdr->addFilterSetting('subscriptiontrack', 'enable', 1);
$hdr->addFilterSetting('twitter', 'enable', 1); #please check the apps available for your current package at www.sendgrid.com/pricing.html ?
$hdr->addTo($receiver);

$hdr->addSubVal('-time-', $times);

$hdr->addSubVal('-name-', $names);
$hdr->setUniqueArgs(array(
    'test' => 1,
    'foo' => 2
));

echo $hdr->as_string();
echo "\n";

?>

