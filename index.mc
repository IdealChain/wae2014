<& page/menu.mi &>

% if ($.page_id) {
  <& page/view.mi, id => $.page_id &>
% } else {
  <& page/newest.mi &>
% }

<%class>
  has 'page_id';
</%class>

<%init>
  # redirect any visitor to component folder so that
  # relative URIs work properly
  if ($m->request_path eq "/wae07") {
    $m->redirect("/wae07/");
  }
</%init>
