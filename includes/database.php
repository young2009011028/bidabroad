<?php
include"user_class.php";
class database_controllder{

    //function
    function WriteStudentToDataBase(student_user $student){
    	$servername = 'localhost';
    	$username='bid_user';
    	$password='bidabroad';
    	$dbname = 'ba';
    	try {
		$conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    		echo "Connected\n";
    	} catch (Exception $e) {
    		die("Unable to connect: " . $e->getMessage());
    	}
    	
    	try {
    		//$conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);

			$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
			$conn->beginTransaction();
    		$conn->exec("set names 'utf8'");
    		$conn->exec("set character_set_client=utf8");
    		$conn->exec("set character_set_results=utf8");
    		
    		$sql = "Insert INTO users(user_id,user_type) VALUES (UNHEX('$student->user_id'),'S')";
    		$conn->exec($sql);
    		 echo "New users record created successfully";
    		 
    		 $sql = "Insert INTO configurations (configuration_id,configuration_notification_enabled) VALUES(UNHEX('" . $student->student_configuration->configuration_id."'),'".$student->student_configuration->enabled."')";
    		 $conn->exec($sql);
    		 echo "New configuration record created successfully";
    		 
    		 //$sql =  "Insert INTO students (student_id,student_name,student_email,student_password,student_create_time) VALUES (UNHEX('$student->user_id'),'$student->student_name','$student->student_email','$student->student_password','$student->student_create_time')";
    		 $configid  = $student->student_configuration->configuration_id;
    		 $sql = "Insert INTO students (student_id,student_name,student_email,student_password,student_telephone,student_qq,student_wechat,student_create_time,
    		  student_last_login_time,student_total_access_number,student_is_deleted,student_delete_time,student_configuration_id) VALUES
    		  (UNHEX('$student->user_id'),'$student->student_name','$student->student_email','$student->student_password','$student->student_telephone',
    		  '$student->student_qq','$student->student_wechat','$student->student_create_time','$student->student_last_login_time','$student->student_total_access_number',
    		  '$student->student_is_deleted','$student->student_delete_time',UNHEX('$configid'))"; 
    		 
    		 $conn->exec($sql);
    		 echo "New students record created successfully";
    		 
    		 
    		 
    		 $conn->commit();
    	}
    	catch(PDOException $e)
    	{
    		$conn->rollBack();
    		echo $sql . "<br>" . $e->getMessage();
    	}
    	
    	$conn = null;
    	


         /*  $sql = "Insert INTO students (student_id,student_name,student_email,student_password,student_telephone,student_qq,student_wechat,student_create_time,
                                        student_last_login_time,student_total_access_number,student_is_deleted,student_delete_time,student_configuration_id) VALUES
                                        (UNHEX($student->user_id),$student->student_name,$student->student_email,$student->student_password,$student->student_telephone,
                                        $student->student_qq,$student->student_wechat,$student->student_create_time,$student->student_last_login_time,$student->student_total_access_number,
                                        $student->student_is_deleted,$student->student_delete_time,UNHEX($student->student_configuration->configuration_id))"; */
         // echo "Insert INTO students (student_id,student_name,student_email,student_password,) VALUES (UNHEX($student->user_id),$student->student_name,$student->student_email,$student->student_password)";
    }
  }

?>
