$('#button-new').show();
$('#data_<%= @photo_activity.id %>').html("<%= j(render 'data', :photo_activity => @photo_activity) %>");
$('#toolbar_def').hide();