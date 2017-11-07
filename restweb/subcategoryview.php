<?php
	
    $con=new mysqli("localhost","root","","restaurant");
    
  /*  $name = $_POST['catename'];
    
    define('UPLOAD_DIR', 'image/');
    $img = $_POST['image'];
    
    $img = str_replace('data:image/png;base64,', '', $img);
    $img = str_replace(' ', '+', $img);
    $data = base64_decode($img);
    $file = UPLOAD_DIR . uniqid() . '.png';
    $success = file_put_contents($file, $data);
    print $success ? $file : 'Unable to save the file.';
    
  $query = "insert into datacategory(catename,cateimage)values('$name','$file')";
  //  print ($file);
  $con->query($query);
  */
     $qu = "select * from subcategory";
    
     $rows = $con->query($qu);

    while($row = $rows->fetch_assoc())
     {
        $pp[]  = $row;
        
     }
    
    echo json_encode($pp);
  
    
?>

