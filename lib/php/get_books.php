<?php 
include 'configuration_setup.php';

if(!empty($_GET["id"])){
    $id = $_GET["id"];
    $dbconnect =  mysqli_connect($servername, $username, $password, $database);
    $query = "SELECT * FROM book where id=$id";

    $result = mysqli_query($dbconnect, $query);

    while($row = $result->fetch_assoc()){
	    $list = array(
		    'id' =>$row["id"],
		    'isbn' =>$row["isbn"],
		    'name' =>$row["name"],
		    'year' =>$row["year"],
		    'author' =>$row["author"],
		    'description' =>$row["description"],
		    'image' =>$row["image"],
		    'createdAt' =>$row["createdAt"],
		    'updatedAt' =>$row["updatedAt"]
	    );
    }

    echo json_encode($list);

}else{
    
    $order = "";
    $orderType = "";
    $query = "";
    
    if(!empty($_GET["order"])){
        $order = $_GET["order"];
    }
    
    if(!empty($_GET["orderType"])){
        $orderType = $_GET["orderType"];
    }
    
    $dbconnect =  mysqli_connect($servername, $username, $password, $database);
    
    if(!empty($_GET["order"]) && !empty($_GET["orderType"])){
        $query = "SELECT * FROM book order by $order $orderType ";
    }else{
        $query = "SELECT * FROM book";
    }

    $list = array();

    $result = mysqli_query($dbconnect, $query);

    while($row = $result->fetch_assoc()){
        $createdAt = new DateTime($row["createdAt"]); // Create DateTime object
        $updatedAt = new DateTime($row["updatedAt"]); // Create DateTime object

	    $list[] = array(
            'id' => (int)$row["id"],
            'isbn' => $row["isbn"],
            'name' => $row["name"],
            'year' => (int)$row["year"],
            'author' => $row["author"],
            'description' => $row["description"],
            'image' => $row["image"],
            'createdAt' => $createdAt->format('Y-m-d H:i:s'), // Format date for JSON
            'updatedAt' => $updatedAt->format('Y-m-d H:i:s'), // Format date for JSON
	    );
    }

    echo json_encode($list);
    
}

?>