$( document ).ready(function() {
    $('#toolbar_def').hide();
});

function submit_user(){
	$.ajax({
		url: '/user_managements',
		type: 'post',
		data: {
			user: {
				first_name: $('#user_first_name').val(),
				username: $('#user_username').val(),
				role_id: $('#user_role_id').val(),
				email: $('#user_email').val()
			}
		}
	})
}

function update_user(){
	$.ajax({
		url: '/user_managements/update_user',
		type: 'put',
		data: {
			user: {
				first_name: $('#user_first_name').val(),
				username: $('#user_username').val(),
				role_id: $('#user_role_id').val(),
				email: $('#user_email').val(),
				id: parseInt($('#user_id').val())
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
		$('#button_edit').show();
	}else{
		$('#toolbar_def').show();
		$('#button_edit').hide();
	}
}

function delete_user(){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
	});

	$.ajax({
		url: '/user_managements/delete',
		type: 'delete',
		data: {
			check: check
		}
	});
}

function edit_user(){
	var data_id;
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            data_id = ("/user_managements/"+ $(this).val() +"/edit")
        }
	});
	$.ajax({
		url: (data_id)
	});
}
