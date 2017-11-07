<?php

    $con=new MySQLi("localhost","root","","restaurant");
    
    $id = $_POST["Id"];
    $email = $_POST["email"];
    $pwd = $_POST["password"];

    
    echo $qu="update signup set email='$email', password='$pwd' where Id='$id'";
    echo $qu = "update signup set password='$pwd'  where email='$email' OR username='$user'";

    $con->query($qu);
    
    echo "success";
    
?>

