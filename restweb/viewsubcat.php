<?php
    $con=new mysqli("localhost","root","","restaurant");
    
    
    $id = $_POST['Id'];
    
   // $query = "SELECT username,password from signup where username='$user' and password='$pwd'";
    $query = "SELECT * from subcategory where cateid='$id'";
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






