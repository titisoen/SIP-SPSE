<?php

// cn.php
// Sesuaikan host, port, dbname, user dan password dengan seting pada database server

$cn_str = 'host=localhost port=5432 dbname=epns_prod user=epns password=epns';

$cn = pg_connect($cn_str);

if ($cn){
	echo "Connection succesful.\n";
} else {
	$error = error_get_last();
	echo $error['message'];
}