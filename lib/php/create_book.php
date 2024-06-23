<?php 
include 'configuration_setup.php';

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $requestBody = file_get_contents('php://input');

    if($requestBody != null){
        $conn = mysqli_connect($servername, $username, $password, $database);
        $data = json_decode($requestBody, true);

        // $id = $data['id'];
        $isbn = $data['isbn'];
        $name = $data['name'];
        $year = $data['year'];
        $author = $data['author'];
        $description = $data['description'];
        $image = $data['image'];
        $createdAt = $data['createdAt'];
        $updatedAt = $data['updatedAt'];

        $sql = "INSERT INTO book (isbn, name, year, author, description, image, createdAt, updatedAt)
        VALUES ('$isbn', '$name', '$year', '$author', '$description', '$image', '$createdAt', '$updatedAt')";

        mysqli_query($conn, $sql);

    }
}

?>