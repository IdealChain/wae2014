<& page/menu.mi &>

<& page/view.mi, id => $.page_id &>

<%class>
  has 'page_id' => (default => 1);
</%class>

<%init>
  # redirect any visitor to component folder so that
  # relative URIs work properly
  if ($m->request_path eq "/wae07") {
    $m->redirect("/wae07/");
  }
</%init>
