<%class>
has 'maintitle' => (default => 'WAE Group 7');
</%class>

<%augment wrap>
<!doctype html>
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="static/css/style.css">
% $.Defer {{
      <title><% $.maintitle %></title>
% }}
	<% $.head %>
    </head>
    <body>
	
	  <div id="main_container">
	    <& template/header.mi &>
	    <& template/greenBox.mi &>
        <& template/mainContent.mi &>
		
% if (my $message = delete($m->session->{message})) {
        <div class="message" style="color:red"><% $message %></div>
% }
        <% inner() %>
        <& template/footer.mi, grp => '7' &>
      </div>
    </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>

<%method head>
% #override in component do add more tags to head
</%method>

<%method loggedin>
% return defined($m->session->{'user_id'}) and defined($m->session->{'user_name'});
</%method>
