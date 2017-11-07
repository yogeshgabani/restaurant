<?php
    $con=new mysqli("localhost","root","","MANNN");
    
    
    
    $psku=$_POST['id'];
    
    
    $qu="select * from product_jeans_tbl ";
    $pp= $con->query($qu);
    
    while($ff=$pp->fetch_object())
    {
        $qq[]=$ff;
    }
    echo json_encode($qq);
    
    
    
    
    
    
    
    ?>
