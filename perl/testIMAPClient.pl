#!/usr/bin/perl

use strict 'vars';
use warnings;
no warnings qw(uninitialized numeric);
use Getopt::Long;
use POSIX qw(setsid);


my $host = "imap.gmail.com";
my $user = 'smartercn@gmail.com';
my $password = 'dope3026';
my $port = 993;

use Mail::IMAPClient;
use Email::MIME;
  
#connect to imap server
my $imap = Mail::IMAPClient->new(
							User=>$user,
							Password=>$password,
							Server=>$host,
							Port=>$port,
							UID=>1, 
							Peek=>1,
							Ssl=>1,
							Ignoresizeerrors=>1	) or die "Incorrect Password";

$imap->select("INBOX");
my @messages = $imap->sentsince(time - 24 * 3600 * 32);

#loop through messages
foreach my $msgid (@messages)
{
	my $header = getHeader($imap,$msgid);

	print "processing '" . $$header{"subject"} . "'\n";
	my $bodystr = $imap->message_string($msgid);

	eval{
		Email::MIME->new($bodystr)->walk_parts(
			sub
			{
				my ($part) = @_;
				
				return unless $part->content_type =~ /\bname="([^"]+)"/;
				my $attachmentfilename = $1;
				
				
				print  $part->content_type =~ m!^text/! 
							? $part->body_str 
							: $part->body ;
			}
		);
	};
	
	if($@)
	{
		print "an error occurred when parsing mail body: $bodystr \n";
		print $@,"\n";
		die $@,"\n";
	}
}

#Close IMAP session
$imap->close;




print "<<<< SUCCESS >>>>\n";
exit 0;

sub getHeader{
	my ($imap,$msg_id,$count) = @_;
	
	my $data = $imap->parse_headers($msg_id, "From", "Subject", "Date");
	if(!$data){
	        print "There isn't message which id is $msg_id./n";
	        return {};
	}
	
	my $subject = defined($data->{Subject}->[0]) ? $data->{Subject}->[0] : 'no subject';
	my $from = $data->{From}->[0];
	my $date = $data->{Date}->[0];
	return {
		"subject" => $subject,
		"from" => $from,
		"date" => $date,
	};
}

sub printfolders
{
	my ($imap) = @_;
	my $folders = $imap->folders();
	foreach my $foldername (@$folders)
	{
		next if($foldername =~ /^Public Folders/i);
		print $foldername,"\n";
	}
}

__END__

