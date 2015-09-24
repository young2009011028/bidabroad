<?php
include "guid_creator.php"
		class user{
			public $user_id;
			public $user_type;

			//function
			public function __construct($type)
			{
			  $this->user_id=UUID::v4_no_hyphen();
			  $this->user_type = $type;
			}
		}
		class user_configuration{
			public $configuration_id;
			public $enabled;
			public function __construct()
			{
				$this->configuration_id = UUID::v4_no_hyphen();
				$this->enabled = true;
			}
		}
		class student_user extends user{
			public $student_name;
			public $student_email;
			public $student_password;
			public $student_telephone;
			public $student_qq;
			public $student_wechat;
			public &student_create_time;
			public $student_last_login_time;
			public $student_total_access_number;
			public $student_is_deleted;
			public $student_delete_time;
			public $student_configuration;
			public function __construct()
			{
				$this->student_configuration = new user_configuration;
			}
		}
?>
