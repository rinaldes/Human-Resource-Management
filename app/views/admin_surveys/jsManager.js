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

function delete_admin_survey(){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
	});
	$.ajax({
		url: '/admin_surveys/delete',
		type: 'delete',
		data: {
			check: check
		}
	});
}