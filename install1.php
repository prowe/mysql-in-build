<?php

echo "starting install\n";

$cmd = 'mysqld --user=mysql';
$outputfile = 'mysql.log';
$pidfile = 'mysql.pid';
exec(sprintf("%s > %s 2>&1 & echo $! >> %s", $cmd, $outputfile, $pidfile));

echo "my SQL Started\n";
sleep(5);

exec("mysql -uroot -hlocalhost < setRootPassword.sql");
echo exec("ps -ef");

// -----------

$mysqli = new mysqli("localhost", "root", "password");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
echo $mysqli->host_info . "\n";


echo "stopping\n";
exec('killall mysqld');

echo "killed\n";
