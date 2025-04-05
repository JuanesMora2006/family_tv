<?php
// Database connection
$host = "localhost";
$user = "root";
$password = "";
$database = "family_tv";

$con = mysqli_connect($host, $user, $password, $database);

// Check connection
if (!$con) {
    die("conexión fallida: " . mysqli_connect_error());
}
else {
    echo"Conexión exitosa a la base de datos.";
}
?>