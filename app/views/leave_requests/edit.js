<% if params[:for_approval].present? %>
  $("#myModal").html("<%= j(render 'approval') %>")
  $('.close-modal').click();
  $('#myModal').modal()
  <% else %>
$('#data_<%= @leave_request.id %>').html("<%= j(render 'form', :leave_request => @leave_request) %>");
$('#button-new').hide();
$('.input-append.date').datepicker({
  autoclose: true,
  todayHighlight: true
});
<% end %>