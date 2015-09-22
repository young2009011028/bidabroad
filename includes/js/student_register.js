


$(document).ready(function(){

    $('#btnConfirm').click(function(){
        var clickBtnValue = $(this).val();
        var ajaxurl = '/includes/student_register_modal.php',
        data =  {'action': clickBtnValue};
        $.post(ajaxurl, data, function (response) {
            // Response div goes here.
            alert(response);
        });
    });

});
