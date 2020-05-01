$('#button-new').show();
$('#data_<%= @external_work_experience.id %>').html("<%= j(render 'data', :external_work_experience => @external_work_experience) %>");
 $('#toolbar_external_work_experience').addClass("hide");
	  $('#button_edit_external_work_experience').addClass("hide");
	  $('#button_remove_external_work_experience').addClass("hide");
	  $(".child-box").each(function(){
  $(this).click(function() {
    section = $(this).attr("data-section")
    children = $(".child-" + section)
    // $(this).parent().parent().parent().toggleClass('row_selected')

    show_button($(this))
    
    selected_count = 0
    children.each(function(){ if ($(this).is(':checked')) { selected_count += 1 } })
    if (selected_count==children.length) {
      $(".parent-" + section).prop('checked', true)
    } else{
      $(".parent-" + section).prop('checked', false)
    };
  })
})