<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "chatapp";
    
    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    $code=$_POST["code"];
    $mono=$_POST["mono"];
    
    $sql = "select * from registration where mono = '$mono';";
    
    $sql .= "insert into registration(code,mono)values('$code','$mono')";
    
    if ($conn->multi_query($sql) === TRUE) {
        echo "New records created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
    $conn->close();
    ?>
