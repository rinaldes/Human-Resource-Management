<% if params[:for_pending].present? %>
  $("#myModal").html("<%= j(render 'pending') %>")
  $("#myModal").modal()
<% elsif params[:for_applicant].present? %>
	$('#data_<%= @test_result.id %>').html("<%= j(render 'status', :test_result => @test_result) %>");
	$('#button-new').hide();
<% elsif params[:for_applicant_edit].present? %>
	$('#data_<%= @test_result.id %>').html("<%= j(render 'form', :test_result => @test_result) %>");
	$('#button-new').hide();
<% else %>
	$("#myModal").html("<%= j(render 'edit') %>")
	$("#myModal").modal()
<% end %>
