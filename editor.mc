<%class>
  has 'id';
  has 'title';
  has 'content' => (default => "<font face=Verdana>Please enter your text here!\n</font>\n");
  has 'save';
  has 'parent_id';
</%class>

<%method head>
	<script src="static/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="static/css/editor.css">
</%method>

<%method printParentOptions ($pages, $level, %tree)>
% foreach my $id (sort keys %tree) {
	<option value="<% $id  %>"
% if ($id == $.parent_id) {
	selected
% }
	
	>
% for (my $i = $level; $i >= 1; --$i) {
	&nbsp;
% }
		<% $pages->{$id}->{'title'} %>
	</option>
% if ($tree{$id}) {
		<% $.printParentOptions($pages, $level + 1, %{$tree{$id}}) %>
% }
% }
</%method>

<div class="editor">
		
<h2 class="page_title">
% if (defined($.id)) {
  Edit page <% $.id %>
% } else {
  Create new page
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
	<select id="parentInput" name="parent_id">
		<option value="0">&lt;root&gt;</option>
		<% $.printParentOptions($pages, 0, %pageTree) %>
	</select>
</div>

<div class="formField">
	<textarea name="content" id="content"><% $.content %></textarea>
	<script>
		// Replace the <textarea id="content"> with a CKEditor
		// instance, using default configuration.
		CKEDITOR.replace('content',{
			width   : '800px',
			height  : '480px'
		});
	</script>
</div>

<div id="formButtons">
  <input type="submit" value="Save Changes" name="save">
% if ($pagelink) {
  <a href="<% $pagelink %>">Cancel / Back to page</a>
% } else {
  <a href=".">Cancel</a>
% }
</div>

</form>
	
</div> <!-- editor -->

<%init>
	use Data::Dumper;

	my $dbh = Ws14::DBI->dbh();
	my $msg = "";
	my $sth = $dbh->prepare("select id, parent_id, title from wae07_pages");
	$sth->execute();
	my $pages = $sth->fetchall_hashref("id");
	my %pageTree = $m->comp('page/pageTree.mp');

  my $pagelink = sprintf('index?page_id=%d', $.id) if $.id;

  if (not $.loggedin) {
    $m->session->{'message'} = "Please log in for creating and editing pages!";
    $m->redirect(".");
  }

	# $m->print("Content:". $.content . ",<br/> args(content):" . $.args->{'content'} . "<br/>");
	if ($.save) { # Speichern wurde gedrückt...
		if ($.id) {
			# Datensatz in Datenbank ändern
			my $sth = $dbh->prepare("UPDATE wae07_pages SET content = ?, title = ?, parent_id = ? WHERE id = ?");
			$sth->execute($.content, $.title, ($.parent_id > 0) ? $.parent_id : undef, $.id);
			$msg = "Page " . $.id ." updated.";
		} else {
			# Datensatz aus Formularfeldern in Datenbank einfügen
			my $sth = $dbh->prepare("INSERT INTO wae07_pages (content,title,parent_id,author_user_id,created) values (?,?,?,?,NOW())");
			$sth->execute($.content, $.title, ($.parent_id > 0) ? $.parent_id : undef, $m->session->{'user_id'});
			$.id($sth->{mysql_insertid});
			$msg = "Page ". $.id ." created.";
		}
	} elsif ($.id) {
		# id erkannt, daten aus Datenbank lesen
		my $sth = $dbh->prepare("SELECT id, title, content, created, parent_id from wae07_pages WHERE id = ?");
		$sth->execute($.id);
		my $res = $sth->fetchrow_hashref();
		$.content($res->{content} || $.content);
		$.title($res->{title});
		$.parent_id($res->{parent_id});
		$msg = "Page " . $.id . " fetched from DB.";
	}
</%init>
