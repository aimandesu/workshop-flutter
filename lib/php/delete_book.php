<?php 
include 'configuration_setup.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $dbconnect = mysqli_connect($servername, $username, $password, $database);
  
    // Get the ID from the request body
    $data = json_decode(file_get_contents('php://input'), true);
    $id = $data['id'];
  
    $sql = "DELETE FROM book WHERE id='$id'";
    mysqli_query($dbconnect, $sql);
  }

?>