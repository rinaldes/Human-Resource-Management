function submit_test(){
    $.ajax({
        url: '/test_results',
        type: 'post',
        data: {
            test_result: {
                applicant_name: $('#test_result_applicant_name').val(),
                attachment: $('#test_result_attachment').val(),
                position_id: $('#test_result_position_id').val(),
                status: $('#test_result_status').val(),
                recruitment_id: $('#test_result_recruitment_id').val(),
                cv_status: $('#test_result_cv_status').val(),
                email: $('#test_result_email').val()
            }
        }
    })
}
function update_test(){
    $.ajax({
        url: '/test_results/update_test',
        type: 'put',
        data: {
            test_result: {
                applicant_name: $('#test_result_applicant_name').val(),
                attachment: $('#test_result_attachment').val(),
                position_id: $('#test_result_position_id').val(),
                status: $('#test_result_status').val(),
                recruitment_id: $('#test_result_recruitment_id').val(),
                cv_status: $('#test_result_cv_status').val(),
                email: $('#test_result_email').val(),
                id: parseInt($('#test_result_id').val())
            }
        }
    })
}
function update_status_test(){
    $.ajax({
        url: '/test_results/update_status_test',
        type: 'put',
        data: {
            test_result: {
                cv_status: $('#test_result_cv_status').val(),
                id: parseInt($('#test_result_id').val())
            }
        }
    })
}
function cek_checkbox(){
    $('#toolbar_def').removeClass('hide');
    if($('input:checkbox:checked').length == 0){
        $('#toolbar_def').hide();
    }else if($('input:checkbox:checked').length == 1){
        $('#toolbar_def').show();
    }else{
        $('#toolbar_def').show();
    }
}
function delete_test(){
    var check = [];
    $('input[type=checkbox]').each(function(){
        if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
    });
    $.ajax({
        url: '/test_results/delete',
        type: 'delete',
        data: {
            check: check
        }
    });
}
function edit_test(){
    var data_id;
    $('input[type=checkbox]').each(function(){
        if ($(this).is(":checked")) {
            data_id = ("/test_results/"+ $(this).val() +"/edit?for_applicant_edit=1&locale=en")
        }
    });
    $.ajax({
        url: (data_id)
    });
}