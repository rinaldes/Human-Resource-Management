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

function submit_category(){
  $.ajax({
    url: '/categories',
    type: 'post',
    data: {
      category: {
        name: $('#category_name').val(),
        category_group: $('#category_category_group').val()
      }
    }
  })
}

function update_category(){
  $.ajax({
    url: '/categories/update',
    type: 'put',
    data: {
      category: {
        name: $('#category_name').val(),
        category_group: $('#category_category_group').val(),
        id: parseInt($('#category_id').val())
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

function delete_category(){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
	});
	$.ajax({
		url: '/categories/delete',
		type: 'delete',
		data: {
			check: check
		}
	});
}

function edit_category(){
	var data_id;
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            data_id = ("/categories/"+ $(this).val() +"/edit")
        }
	});
	$.ajax({
		url: (data_id)
	});
}
