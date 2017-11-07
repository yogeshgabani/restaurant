<?php
	
    $con=new mysqli("localhost","root","","restaurant");
    
    $emp_name = $_REQUEST["name"];
    $emp_email = $_REQUEST["email"];
    $emp_user = $_REQUEST["user"];
    $emp_mob  =  $_REQUEST["mob"];
    $emp_gender = $_REQUEST["gender"];
    $emp_pass = $_REQUEST["pass"];
    
  $query = "insert into signup(name,email,username,mobile,gender,password)values('$emp_name','$emp_email','$emp_user','$emp_mob','$emp_gender','$emp_pass')";
    print($query);
  $con->query($query);
  
     $qu = "select * from signup";
    
     $rows = $con->query($qu);

    while($row = $rows->fetch_assoc())
     {
        $pp[]  = $row;
        
     };
    
    echo json_encode($pp);
    
    
?>

