<?php
	
    $con=new mysqli("localhost","root","","restaurant");
    
   
    $user_id = $_POST['user_id'];
   
    
    $query = "SELECT productcategory.prodid,productcategory.prodimage,productcategory.prodname,cart.price,cart.size,cart.cid FROM productcategory,cart WHERE productcategory.prodid = cart.prodid AND cart.sr_no = '$user_id'";
 // $query = " SELECT productcategory.prodid,productcategory.prodimage,productcategory.prodname,productcategory.price,productcategory.size FROM productcategory,cart WHERE productcategory.prodid = cart.prodid AND cart.sr_no = '$user_id'";
 
 
    
    $rows = $con->query($query);
    $nm = $rows->num_rows;
    
    if ($nm>=1)
    {
        while($row = $rows -> fetch_assoc())
        {
            $pp[] = $row;
            
        }
        
        echo json_encode($pp);
    }
    else
    {
        
        $items = [];
        echo json_encode($items);
        
    }
    
    
?>

