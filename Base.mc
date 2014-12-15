<%class>
has 'maintitle' => (default => 'WAE Group 7');
</%class>

<%augment wrap>
<!doctype html>
  <html>
    <head>
      <link rel="stylesheet" href="static/css/style.css">
% $.Defer {{
      <title><% $.maintitle %></title>
% }}
	<% $.head %>
    </head>
    <body>
% if (my $message = delete($m->session->{message})) {
      <div class="message" style="color:red"><% $message %></div>
% }
      <% inner() %>
      <& footer.mi, grp => '7' &>
    </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>

<%method head>
% #override in component do add more tags to head
</%method>
