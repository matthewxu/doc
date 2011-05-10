use dbo;
my $dbo=dbo->new();
my $tablename="www_1";
my $title="test1\ttest2\tname";
#$dbo->createtable($tablename,$title);
#$dbo->createtable($tablename,$title);
my $sql="insert into www_11(test1,test2,name) values(?,?,?)";
my @s1=();
my $s2="1\t\t";

push @s1,$s2;
push @s1,$s2;
push @s1,$s2;
push @s1,$s2;
push @s1,$s2;

$dbo->insert($sql,\@s1);
__END__
	print $sql."\n";
	my $dbh=$dbo->checkdbconnection();	
	my $sth = $dbh->prepare("$sql");
	$sth->bind_param(1, 11);
	$sth->bind_param(2, 11);
	$sth->bind_param(3, 33);
			
			if (!$sth->execute) {
				print "Error:" . $sth->errstr . "\n";
				return 2;
			}
	$dbh->commit();
		
		