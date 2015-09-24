<?php
include "guid_creator.php"
    class user
	{
    public $user_id;
    public $user_type;

    //function
    public function __construct($type)
    {
      $this->user_id=UUID::v4_no_hyphen();
      $this->user_type = $type;
    }
  }
?>
