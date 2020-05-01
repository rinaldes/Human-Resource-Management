$('#data_<%= @goal_value.id %>').replaceWith("<%= j(render 'form', :goal_value => @goal_value) %>");

$('#button-new').hide();
$('.input-append.date').datepicker({
  autoclose: true,
  todayHighlight: true
});