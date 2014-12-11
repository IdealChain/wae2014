has 'id';
has 'parent_id';
has 'title' => (required => 1);
has 'content' => (required => 1);

method handle() {
  my $dbh = Ws14::DBI->dbh();
  
  if (defined $.id) {
    my $sth = $dbh->prepare("update wae07_pages set parent_id=?, title=?, content=? where id=?");
    $sth->execute($.parent_id, $.title, $.content, $.id);
    $m->clear_and_abort(404) if $sth->rows == 0;
    $m->session->{message} = sprintf("Page '%s' updated.", $.title);
  } else {
    my $sth = $dbh->prepare("insert into wae07_pages (parent_id, title, content, author_user_id) values (?,?,?,?)");
    $sth->execute($.parent_id, $.title, $.content, $m->session->{user_id});
    $.id = $sth->{mysql_insertid};
    $m->session->{message} = sprintf("Page '%s' created.", $.title);
  }
  $m->redirect(sprintf('view?id=%d', $.id));
}
