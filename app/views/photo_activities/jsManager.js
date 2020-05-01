$( document ).ready(function() {
    $('#toolbar_def').hide();
});

$(document).ready(function () {
    (function ($) {
        $('#filter').keyup(function () {
            var rex = new RegExp($(this).val(), 'i');
            $('.searchable tr').hide();
            $('.searchable tr').filter(function () {
                return rex.test($(this).text());
            }).show();
        })
    }(jQuery));
});

function submit_photo_activity(){
	$.ajax({
		url: '/photo_activities',
		type: 'post',
		data: {
			photo_activity: {
				name: $('#photo_activity_name').val()
			}
		}
	})
}

function update_photo_activity(){
	$.ajax({
		url: '/photo_activities/update',
		type: 'put',
		data: {
			photo_activity: {
				name: $('#photo_activity_name').val(),
				id: parseInt($('#photo_activity_id').val())
			}
		}
	})
}

function cek_checkbox(){
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

function delete_photo_activity(){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
	});
	$.ajax({
		url: '/photo_activities/delete',
		type: 'delete',
		data: {
			check: check
		}
	});
}

function edit_photo_activity(){
	var data_id;
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            data_id = ("/photo_activities/"+ $(this).val() +"/edit")
        }
	});
	$.ajax({
		url: (data_id)
	});
}
