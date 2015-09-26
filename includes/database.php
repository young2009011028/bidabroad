<?php
include"user_class.php";
class database_controllder{
    private $servername = "localhost";
    private $username="root";
    private $password="bidabroad";
    private $dbname = "ba";
    //function
    public function WriteStudentToDataBase(student_user $student){
      //$conn = new mysqli($this->servername,$this->username,$this->password,$this->dbname);
      $conn = new mysqli("localhost","root","bidabroad","ba");
      if($conn->connect_error)
        {
          die("Connection failed: ". $conn->connect_error);
        }
        else
        {
          mysqli_query($conn,"set names 'utf8'");
          mysqli_query($conn,"set character_set_client=utf8");
          mysqli_query($conn,"set character_set_results=utf8");

          $sql = "Insert INTO students (student_id,student_name,student_email,student_password,student_telephone,student_qq,student_wechat,student_create_time,
                                        student_last_login_time,student_total_access_number,student_is_deleted,student_delete_time,student_configuration_id) VALUES
                                        (UNHEX($student->user_id),$student->student_name,$student->student_email,$student->student_password,$student->student_telephone,
                                        $student->student_qq,$student->student_wechat,$student->student_create_time,$student->student_last_login_time,$student->student_total_access_number,
                                        $student->student_is_deleted,$student->student_delete_time,UNHEX($student->student_configuration->configuration_id))";

          if ($conn->query($sql) === TRUE) {
                  echo "New record created successfully";
              }
          else {
                  echo "Error: " . $sql . "<br>" . $conn->error;
              }



        }
        $conn->close();
      }
  }

?>
