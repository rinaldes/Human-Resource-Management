$('#button-new').show();
$('#data_<%= @category.id %>').html("<%= j(render 'data', :category => @category) %>");
$('#toolbar_def').hide();