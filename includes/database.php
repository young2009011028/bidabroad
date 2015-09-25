<?php
include"user_class.php"
class database_controllder{
    private $servername = "localhost";
    private $username="root";
    private $password="bidabroad";

    //function
    public function WriteStudentToDataBase(student_user $student){
      $conn = new mysqli($this->servername,$this->username,$this->password);
      if($conn->connect_error)
        {
          die("Connection failed: ". $conn->connect_error);
        }
        else
        {
          $sql = "Insert INTO ";
        }
      }
  }

?>
