<%class>
  has 'id';
  has 'title';
  has 'content' => (default => "<font face=Verdana>bitte hier den Text eingeben.\n</font>\n");
  has 'save';
  has 'parent_id';
</%class>

<%method head>
	<script src="/static/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="static/css/editor.css">
</%method>

<h2>
% if (defined($.id)) {
Dokument <% $.id %> editieren
% } else {
Neues Dokument anlegen
% }
</h2>
% if (length($msg)) {
<p class="editorMessage"><% $msg %></p>
% }
<form id="editform" name="editform"
% #      action="<% $m->request_path() %>"
method="post" enctype="application/x-www-form-urlencoded">

<input type="hidden" name="id" value="<% $.id %>">

<div class="formField">
	<label for="titleInput">Titel:</label>
	<input type="text" id="titleInput" name="title" value="<% $.title %>" size="50" />
</div>

<div class="formField">
	<label for="parentInput">Parent:</label>
<%doc>
<%  $cgi->popup_menu(-name      =>'parentid',
                       -values    => [ sort keys %docTitleAndIds ],
                       -default   => $parentid,
                       -labels    => \%docTitleAndIds)
  %> aktuell: <% $docTitleAndIds{$parentid} %>
</%doc>
	<input type="text" id="parentInput" name="parent_id" value="<% $.parent_id %>" size="3" />
</div>

<div class="formField">
	<textarea name="content" id="content"><% $.content %></textarea>
	<script>
		// Replace the <textarea id="content"> with a CKEditor
		// instance, using default configuration.
		CKEDITOR.replace('content',{
			width   : '560px',
			height  : '400px'
		});
	</script>
</div>

<div id="formButtons">
	<input type="submit" value="&Auml;nderungen speichern" name="save">
	<input type="reset" value="&Auml;nderungen verwerfen" name="cancel">
</div>

</form>

<%init>
	use Data::Dumper;

	my $dbh = Ws14::DBI->dbh();

	my $msg = "Welcome to the WCM content editor.";
	my %docTitleAndIds = ('0', 'top level document');
  
  if (not $.loggedin) {
    $m->session->{'message'} = "Please log in for creating and editing pages!";
    $m->redirect(".");
  }

	my $sth = $dbh->prepare("SELECT id, title from wae07_pages");
	$sth->execute();
	while (my $res = $sth->fetchrow_hashref()) {
		$docTitleAndIds{$res->{id}} = $res->{title};
	}

	# $m->print("Content:". $.content . ",<br/> args(content):" . $.args->{'content'} . "<br/>");
	if ($.save) { # Speichern wurde gedrückt...
		if ($.id) {
			# Datensatz in Datenbank ändern
			my $sth = $dbh->prepare("UPDATE wae07_pages SET content = ?, title = ?, parent_id = ? WHERE id = ?");
			$sth->execute($.content, $.title, ($.parent_id > 0) ? $.parent_id : undef, $.id);
			$msg = "Datensatz " . $.id ." in DB ver&auml;ndert.";
		} else {
			# Datensatz aus Formularfeldern in Datenbank einfügen
			my $sth = $dbh->prepare("INSERT INTO wae07_pages (content,title,parent_id,author_user_id,created) values (?,?,?,?,NOW())");
			$sth->execute($.content, $.title, ($.parent_id > 0) ? $.parent_id : undef, $m->session->{'user_id'});
			$.id($sth->{mysql_insertid});
			$msg = "Datensatz ". $.id ." neu in DB aufgenommen.";
		}
	} elsif ($.id) {
		# id erkannt, daten aus Datenbank lesen
		my $sth = $dbh->prepare("SELECT id, title, content, created, parent_id from wae07_pages WHERE id = ?");
		$sth->execute($.id);
		my $res = $sth->fetchrow_hashref();
		$.content($res->{content} || $.content);
		$.title($res->{title});
		$.parent_id($res->{parent_id});
		$msg = "Datensatz " . $.id . " aus DB gelesen.";
	}
</%init>
