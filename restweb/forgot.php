<?php
    $con=new mysqli("localhost","root","","restaurant");
    
    
    $email = $_POST['email'];
  //  $pwd = $_POST['password'];
    
        
    $query = "SELECT password from signup where email='$email'";
    
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
