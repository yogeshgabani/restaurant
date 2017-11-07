<?php
    $con=new mysqli("localhost","root","","restaurant");
    
    
    $user = $_POST['user'];
    $pwd = $_POST['password'];
    
    
    $query = "SELECT username,password,sr_no from signup where username='$user' and password='$pwd'";
  //  $query = "SELECT * from signup where username='$user' and password='$pwd'";
 //   print($query);
    
    
    $rows= $con->query($query);
    $nm = $rows->num_rows;
    
    	if($nm>=1)
          {
            while($row = $rows -> fetch_assoc())
            {
                $pp[]=$row;
            }
            echo json_encode($pp);
          }
    
          else
            {
                $items = [];
                echo json_encode($items);
            }
    
?>






