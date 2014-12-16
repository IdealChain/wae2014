has 'username';
has 'password';

method handle() {
  my $dbh = Ws14::DBI->dbh();
  my $sth = $dbh->prepare("select id, username, email from wae07_users where username=? and password_hash=sha2(concat(?,password_salt),0)");
  $sth->execute($.username, $.password);
  
  if ($sth->rows > 0) {
    my $user = $sth->fetchrow_hashref;
    $m->session->{'user_id'} = $user->{'id'};
    $m->session->{'user_name'} = $user->{'username'};
    $m->session->{'user_email'} = $user->{'email'};
    $m->session->{'message'} = sprintf("User '%s' logged in.", $user->{'username'});
  } else {
    $m->session->{'message'} = "Username or password not valid! Please try again.";    
  }
  
  $m->redirect("..");
}
