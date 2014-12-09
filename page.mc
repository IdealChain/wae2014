<h1><% $page->{'title'} %></h1>

<div>
  <% $page->{'content'} %>
</div>

<%class>
  has 'id';
</%class>

<%init>
  my $dbh = Ws14::DBI->dbh();
  my $sth = $dbh->prepare("select title, content from wae07_pages where id = ?");
  $sth->execute($.id);
  my $page = $sth->fetchrow_hashref;
</%init>

