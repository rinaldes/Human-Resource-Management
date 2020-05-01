function show_button(element){
	section = element.attr("data-section")
	if (element.attr("data-position")=="parent") {
		if (element.is(':checked')) {
			position=2
		} else{
			position=0
		}
	} else{
		children = $(".child-" + section)
		selected_count = 0
    children.each(function(){ if ($(this).is(':checked')) { selected_count += 1 } })
    if (selected_count>1) {
    	position=2
    } else if(selected_count==1){
    	position=1
    } else {
    	position=0
    }
	}
  if (position==1) {
	  $('#toolbar_'+section).removeClass("hide");
	  $('#button_edit_'+section).removeClass("hide");
	  $('#button_remove_'+section).removeClass("hide");
  } else if(position==2){
	  $('#toolbar_'+section).removeClass("hide");
	  $('#button_edit_'+section).addClass("hide");
	  $('#button_remove_'+section).removeClass("hide");
  } else {
	  $('#toolbar_'+section).addClass("hide");
	  $('#button_edit_'+section).addClass("hide");
	  $('#button_remove_'+section).addClass("hide");
  }
}

function set_delete_url(url){
	$("#modal_delete_button").attr("onclick", "delete_detail('" + url + "')")
	$("#modal_cancel_button").attr("onclick", "unset_delete_url()")
}

function unset_delete_url(){
	$("#modal_delete_button").attr("onclick", "")
	$("#modal_cancel_button").attr("onclick", "")
}

function delete_detail(url){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
      check.push(parseInt($(this).val()))
    }
	});
	$.ajax({
		url: url,
		type: 'delete',
		data: {
			check: check
		}
	});
}

function submit_goal_value(){
	$.ajax({
		url: '/goal_values',
		type: 'post',
		data: {
			goal_value: {
				value: $('#goal_value_value').val(),
			}
		}
	})
}

function update_goal_value(){
	$.ajax({
		url: '/goal_values/update_goal_value',
		type: 'put',
		data: {
			goal_value: {
				value: $('#goal_value_value').val(),
				id: parseInt($('#goal_value_id').val())
			}
		}
	})
}

function delete_goal_value(){
	var check = [];
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            check.push(parseInt($(this).val()))
        }
	});
	$.ajax({
		url: '/goal_values/delete',
		type: 'delete',
		data: {
			check: check
		}
	});
}

function edit_goal_value(){
	var data_id;
	$('input[type=checkbox]').each(function(){
		if ($(this).is(":checked")) {
            data_id = ("/goal_values/"+ $(this).val() +"/edit")
        }
	});
	$.ajax({
		url: (data_id)
	});
}