<h1>All pages</h1>

<ul>
% foreach my $page (values $pages) {
  <li>
    <a href="page?id=<% $page->{'id'} %>">
      <% $page->{'title'} %>
    </a>
  </li>
% }
</ul>

<% scalar(keys $pages) %> pages are here.

<%init>
  my $dbh = Ws14::DBI->dbh();
  my $sth = $dbh->prepare("select id, title from wae07_pages");
  $sth->execute();
  my $pages = $sth->fetchall_hashref("id");
</%init>
