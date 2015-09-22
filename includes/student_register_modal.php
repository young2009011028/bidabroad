
<?php
/*
include("guid_creator.php");
$guid_class = new UUID;
echo $guid_class->v4();
*/

if (isset($_POST['action'])) {
    switch ($_POST['action']) {
        case '确认':
            insert();
            break;
        case 'select':
            select();
            break;
    }
}

function select() {
    echo "The select function is called.";
    exit;
}

function insert() {
    echo "The insert function is called.";
    exit;
}
?>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="/includes/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="/includes/css/bootstrap-theme.min.css">
<!-- Latest compiled and minified JavaScript -->
<script src="/includes/js/bootstrap.min.js"></script>
<script src="/includes/js/jquery-2.1.4.min.js"></script>
<script src="/includes/js/student_register.js"></script>



<button id="btnStudentRegister" type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">学生注册</button> 


<div id="myModal" class="modal fade" role="dialog"> 
  <div class="modal-dialog"> 
    <!-- Modal content--> 
    <div class="modal-content"> 
      <div class="modal-header"> 
        <button type="button" class="close" data-dismiss="modal">&times;</button> 
        <h4 class="modal-title">学生注册</h4> 
      </div> 
      <div class="modal-body"> 
<table>
	<tr>
	<td>
	<label>姓名*</label>
	</td>
	<td>
	<input id="iptName"></input>
	</td>
	</tr>
		<tr>
	<td>
	<label>邮箱*</label>
		</td>
	<td>
	<input id="iptEmail"></input>
	</td>
	</tr>
	
		<tr>
	<td>
	<label>电话</label>
		</td>
	<td>
	<input id="iptPhone"></input>
	</td>
	</tr>
	
			<tr>
	<td>
	<label>微信</label>
		</td>
	<td>
	<input id="iptWechat"></input>
	</td>
	</tr>

			<tr>
	<td>
	<label>QQ</label>
		</td>
	<td>
	<input id="iptQQ"></input>
	</td>
	</tr>
</table>
      </div> 
      <div class="modal-footer"> 
	      <div class="col-md-6">
	        <button type="button" class="btn btn-default " data-dismiss="modal">已有账号，我要登陆</button> 
	        </div>
	        <div  class="col-md-2">
	        <input id="btnConfirm" type="submit" name="insert" value="确认" class="btn btn-default " data-dismiss="modal"></input>    
	         </div>
	        <div  class="col-md-2">
	        <button type="button" class="btn btn-default " data-dismiss="modal">取消</button>    
	         </div>
	      </div> 
    </div> 
  </div> 
</div>



