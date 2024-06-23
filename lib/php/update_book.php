<?php
include 'configuration_setup.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $dbconnect = mysqli_connect($servername, $username, $password, $database);

  // Get the book data from the request body
  $data = json_decode(file_get_contents('php://input'), true);

  $id = $data['id'];
  $isbn = $data['isbn'];
  $name = $data['name'];
  $year = $data['year'];
  $author = $data['author'];
  $description = $data['description'];
  $image = $data['image'];
  $createdAt = $data['createdAt']; // Assuming it's already a date string
  $updatedAt = $data['updatedAt']; // Set updated date on update

  $sql = "UPDATE book SET isbn='$isbn', name='$name', year='$year', author='$author', description='$description', image='$image', createdAt='$createdAt', updatedAt='$updatedAt' WHERE id='$id'";

  mysqli_query($dbconnect, $sql);
}
?>
