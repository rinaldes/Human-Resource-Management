$('#data_<%= @category.id %>').html("<%= j(render 'form', :category => @category) %>");
$('#button-new').hide();