<?php
	
    $con=new mysqli("localhost","root","","restaurant");
    
    $catnm = $_POST["catename"];
    
    define('UPLOAD_DIR', 'prodimage/');
    $img = $_POST["prodimage"];
    $catid = $_POST["cateid"];
    $img = str_replace('data:prodimage/png;base64,', '', $img);
    $img = str_replace(' ', '+', $img);
    $data = base64_decode($img);
    $file = UPLOAD_DIR . uniqid() . '.png';
    $success = file_put_contents($file, $data);
    print $success ? $file : 'Unable to save the file.';
    
  $query = "insert into productcategory(prodname,prodimage,subid)values('$catnm','$file','$catid')";
    print ($file);
  $con->query($query);
  
     $qu = "select * from productcategory";
    
     $rows = $con->query($qu);

    while($row = $rows->fetch_assoc())
     {
        $pp[]  = $row;
        
     }
  
    echo json_encode($pp);
  
    
?>

