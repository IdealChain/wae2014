method handle() {
  delete $m->session->{'user_id'};
  delete $m->session->{'user_name'};
  delete $m->session->{'user_email'};
  $m->session->{'message'} = "Logged out.";
  $m->redirect("..");
}
