$('#data_<%= @photo_activity.id %>').html("<%= j(render 'form', :photo_activity => @photo_activity) %>");
$('#button-new').hide();