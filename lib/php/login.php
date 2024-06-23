<?php 
include 'configuration_setup.php';

$dbconnect =  mysqli_connect($servername, $username, $password, $database);

$username = $_POST['username'];
$password = $_POST['password'];
$option = "";

if(strpos($username, "@") !== false){
    $option = "email";
}else{
    $option = "username";
}

$login = "SELECT * FROM users WHERE $option = '$username' and password = '$password' ";
    
$result = mysqli_query($dbconnect, $login);
    
$numResult = mysqli_num_rows($result);

if($numResult == 1){
	while($row = $result->fetch_assoc()){
        
    $list =  array(
        'id' =>(int)$row["id"], 
        'email' => $row['email'], 
        'username' =>$row["username"],
        'password' => $row['password'],
        'token' => (int)$row['token'],
        'lease' => $row['lease'],
        'role' => $row['role'],
        'is_active' => (int)$row['is_active'],
        'secret' => $row['secret']
        );
	}

	echo json_encode($list);

}else{

    $list =  array('status' => 401, 'error' => array(
        "code" => 401,
        "status" => "Unauthorized",
        "message" => "Invalid email, username or password!"
    ));

    echo json_encode($list);

}

?>