<%class>
  has 'page_id';
  has 'search';
</%class>

<%init>
  # redirect any visitor to component folder so that
  # relative URIs work properly
  if ($m->request_path eq "/wae07") {
    $m->redirect("/wae07/");
  }
</%init>

<%method head>
	<link rel="stylesheet" href="static/css/newest.css">
</%method>

% if ($.page_id) {
  <& page/view.mi, id => $.page_id &>
% } elsif ($.search) {
  <& page/search.mi, search => $.search &>
% } else {
  <& page/newest.mi &>
% }
