<?php
	
    $con=new mysqli("localhost","root","","restaurant");
    
    $pr_id = $_POST['id'];
    
   // $user_id = $_POST['user_id'];
   // $siz = $_POST['size'];
   // $amt = $_POST['price'];

    
    
    $sql = "DELETE FROM cart WHERE cid = '$pr_id'";
        
        if ($con->query($sql) === TRUE) {
            echo "Record deleted successfully";
        } else {
            echo "Error deleting record: " . $con->error;
        }
        
      //  $conn->close();
    ?>
    
 /*
    
  $query = "insert into cart(prodid,sr_no,size,price)values('$id','$user_id','$siz','$amt')";
  print ($query);
     $con->query($query);
    $qu = "select * from cart";
    $rows = $con->query($qu);
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
*/
