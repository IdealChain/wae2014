<%class>
  has 'id';
  has 'title';
  has 'content' => (default => "<font face=Verdana>bitte hier den Text eingeben.\n</font>\n");
  has 'metatext';
  has 'save';
  has 'insert' => (default => 0);
  has 'parent_id';
</%class>

<%method head>
	<script src="/static/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="static/css/editor.css">
</%method>

<h2>
% if (defined($.id) && ($.insert==0)) {
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
<input type="hidden" name="insert" value="<% $.insert %>">

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

	my $sth = $dbh->prepare("SELECT id, title from wae07_pages");
	$sth->execute();
	while (my $res = $sth->fetchrow_hashref()) {
		$docTitleAndIds{$res->{id}} = $res->{title};
	}

	# $m->print("Content:". $.content . ",<br/> args(content):" . $.args->{'content'} . "<br/>");
	if ($.save) {
	# Speichern wurde gedrückt...
		if ($.insert == 1) {
			# Datensatz aus Formularfeldern in Datenbank einfügen
			my $sth = $dbh->prepare("INSERT INTO wae07_pages (id,content,title,parent_id,created) values (?,?,?,?,NOW())");
			$sth->execute($.id,$.content,$.title,$.parentid);
			$msg = "Datensatz ". $.id ." neu in DB aufgenommen.".$sth->rows();
			$.insert(0);
		} else {
			# Datensatz in Datenbank ändern
			my $sth = $dbh->prepare("UPDATE wae07_pages SET content = ?, title = ?, parent = ? WHERE id = ?");
			$sth->execute($.content,$.title,$.parentid,$.id);
			$msg = "Datensatz " . $.id ." in DB ver&auml;ndert.".$sth->rows();
		}
	} elsif ($.id) {
		# id erkannt, daten aus Datenbank lesen
		my $sth = $dbh->prepare("SELECT id, title, content, created, parent, metatext from wae07_pages WHERE id = ?");
		$sth->execute($.id);
		my $res = $sth->fetchrow_hashref();
		$.content($res->{content} || $.content);
		$.title($res->{title});
		$.parentid($res->{parent});
		$msg = "Datensatz " . $.id . " aus DB gelesen.".((defined($res) && scalar(keys(%$res)))?1:0);
	} else {
		# keine ID, neues Dokument erstellen
		my $sth = $dbh->prepare("SELECT max(id) as maxid FROM wae07_pages");
		$sth->execute();
		my $res = $sth->fetchrow_hashref();
		$.id($res->{maxid}+1);
		$.insert(1);
	}
</%init>
