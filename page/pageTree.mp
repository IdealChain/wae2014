
method main() {
	my $dbh = Ws14::DBI->dbh();
	my $sth = $dbh->prepare("select id, parent_id, title from wae07_pages");
	$sth->execute();
	my $pages = $sth->fetchall_hashref("id");

	# build an actual hierarchical tree from the db data that only has
	# a parent reference
	my %pageTree = ();
	
	# level 1
	my %pagesWithParent;
	foreach my $id (keys $pages) {
		if (not defined $pages->{$id}->{'parent_id'}) { 
			$pageTree{$id} = {};
		} else {
			$pagesWithParent{$id} = $pages->{$id};
		}
	}
	
	# level 2
	my %level2Pages = ();
	foreach my $id (keys %pagesWithParent) {
		my $parentId = $pagesWithParent{$id}->{'parent_id'};
		if (exists $pageTree{$parentId}) {
			$pageTree{$parentId}->{$id} = {};
			$level2Pages{$id} = $pageTree{$parentId}->{$id};
		}
	}
	
	# level 3
	foreach my $id (keys %pagesWithParent) {
		my $parentId = $pagesWithParent{$id}->{'parent_id'};
		if (exists $level2Pages{$parentId}) {
			$level2Pages{$parentId}->{$id} = {};
		}
	}
	
	return %pageTree;
}
