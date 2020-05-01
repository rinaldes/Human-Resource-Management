$('#data_<%= @goal.id %>').replaceWith("<%= j(render 'form', :goal => @goal) %>");

$('#button-new').hide();
