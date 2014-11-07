<%class>
has 'maintitle' => (default => 'WAE Group 7');
</%class>

<%augment wrap>
  <html>
    <head>
      <link rel="stylesheet" href="static/css/style.css">
      <script src="/static/js/ckeditor/ckeditor.js"></script>
% $.Defer {{
      <title><% $.maintitle %></title>
% }}
    </head>
    <body>
      <% inner() %>
      <& footer.mi, grp => '7' &>
    </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>