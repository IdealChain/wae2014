has 'id' => (required => 1);

method handle() {
  if (not $.loggedin) {
    $m->session->{'message'} = "Please log in for creating and editing pages!";
    $m->redirect("..");
  }
  
  my $dbh = Ws14::DBI->dbh();
  my $sth = $dbh->prepare("delete from wae07_pages where id=?");
  $sth->execute($.id);

  $m->session->{message} = "Page deleted!" if $sth->rows == 1;
  $m->redirect('..');
}
