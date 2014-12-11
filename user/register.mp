has 'username';
has 'password';
has 'email';

method create_salt {
  my @salt_chars = ('.', '/', 0..9, 'A'..'Z', 'a'..'z');
  my $len = 8;
  my $salt;
  while ($len--) { $salt .= $salt_chars[rand @salt_chars]; }
  return $salt;
}

method handle() {
  if ($.username eq "" or $.password eq "") {
    $m->session->{'message'} = "Username AND password are required.";
    $m->redirect(sprintf("../register?username=%s&email=%s", $.username, $.email));
  }
  
  my $dbh = Ws14::DBI->dbh();
  my $salt = create_salt();  
  my $sth = $dbh->prepare("insert into wae07_users (username, password_hash, password_salt, email) values (?,sha2(?,0),?,?)");
  $sth->execute($.username, $.password.$salt, $salt, $.email);
  
  $m->session->{'message'} = sprintf("User '%s' created, please login.", $.username);
  $m->redirect("..");
}
