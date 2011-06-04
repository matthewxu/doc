		#!/usr/bin/perl
		
		use strict 'vars';
		use warnings;
		no warnings qw(uninitialized numeric);
		use Getopt::Long;
		use POSIX qw(setsid);
		use Spreadsheet::ParseExcel;
		use Mail::IMAPClient;
		use Email::MIME;
		my $host     = "imap.gmail.com";
		my $user     = 'smartercn@gmail.com';
		my $password = 'dope3026';
		my $port     = 993;
		
	
		
		#connect to imap server
		my $imap = Mail::IMAPClient->new(
			User             => $user,
			Password         => $password,
			Server           => $host,
			Port             => $port,
			UID              => 1,
			Peek             => 1,
			Ssl              => 1,
			Ignoresizeerrors => 1
		  )
		  or die "Incorrect Password";
		
		$imap->select("INBOX");
		my @messages = $imap->sentsince( time - 24 * 3600 * 32 );
		
		#loop through messages
		foreach my $msgid (@messages) {
			my $header = getHeader( $imap, $msgid );
		
			print "processing '" . $$header{"subject"} . "'\n";
			my $bodystr = $imap->message_string($msgid);
		
			eval {
				Email::MIME->new($bodystr)->walk_parts(\&parseremailbody);
				
			};
		
			if ($@) {
				print "an error occurred when parsing mail body: $bodystr \n";
				print $@, "\n";
				die $@, "\n";
			}
		}
		
		#Close IMAP session
		$imap->close;
		
		print "<<<< SUCCESS >>>>\n";
		exit 0;

sub parseremailbody
{
	
	my ($part,$test) = @_;
						return unless $part->content_type =~ /\bname="([^"]+)"/;
						my $attachmentfilename = $1;
		
						#				print				$part->content_type =~ m!^text/!
						#							? $part->body_str
						#							: $part->body ;
		
						open my $fh, "> $attachmentfilename"
						  or die "$0: open $attachmentfilename: $!";
						print $fh $part->content_type =~ m!^text/!
						  ? $part->body_str
						  : $part->body
						  or die "$0: print $attachmentfilename: $!";
						close $fh or warn "$0: close $attachmentfilename: $!";
		
						#############parser
						my $oExcel = new Spreadsheet::ParseExcel;
		
						die
		"You must provide a filename to $0 to be parsed as an Excel file"
						  unless $attachmentfilename;
						next unless($attachmentfilename =~ /^daily\s+cost\s+report\s+for\s+smcn-sogou-([0-9]{4})-([0-9]{2})-([0-9]{2})\.xls$/i);
						
						
						my $costdate = "$1$2$3";
						open my $fh2, "> costreport_$costdate.dat"
						  or die "$0: open costreport_$costdate.dat: $!";
						my $oBook = $oExcel->Parse($attachmentfilename);
						my ( $iR, $iC, $oWkS, $oWkC );
						print "FILE  :", $oBook->{File},       "\n";
						print "COUNT :", $oBook->{SheetCount}, "\n";
		
						print "AUTHOR:", $oBook->{Author}, "\n"
						  if defined $oBook->{Author};
		
						for (
							my $iSheet = 0 ;
							$iSheet < $oBook->{SheetCount} ;
							$iSheet++
						  )
						{
							$oWkS = $oBook->{Worksheet}[$iSheet];
	
							my $sheetname=$oWkS->{Name};
							#daily cost report for smcn-sogou-2011-05-29.xls
							
							
	
							print "--------- SHEET:$costdate\t", $oWkS->{Name}, "\n";
							my $coldefined=();
							my $iR = $oWkS->{MinRow} ;
							while (	$iR <= $oWkS->{MaxRow})
							{
								my $rowdata=();
								for (
									my $iC = $oWkS->{MinCol} ;
									defined $oWkS->{MaxCol} && $iC <= $oWkS->{MaxCol} ;
									$iC++
								  )
								{
									$oWkC = $oWkS->{Cells}[$iR][$iC-1];
	#								print "( $iR , $iC ) =>", $oWkC->Value, "\n"  if ($oWkC);
	#								$rowline.="\t".$oWkC->Value if ($oWkC);
									if($iR==0){
										print $oWkC->Value."\n";
										$coldefined->{$oWkC->Value}=$iC-1;
										next;
									}else{
										$rowdata->{$iC-1}=$oWkC->Value;
									}							
								}
	#							print $rowline."\n";
								my $avgcpc=$rowdata->{$coldefined->{clickcounts}}?$rowdata->{$coldefined->{consume}}/$rowdata->{$coldefined->{clickcounts}}:0;
								print $fh2 $rowdata->{$coldefined->{date}}."\t".$rowdata->{$coldefined->{adid}}
										."\t".$rowdata->{$coldefined->{adid}}
										."\t".$rowdata->{$coldefined->{grpid}}
										."\t".$rowdata->{$coldefined->{clickcounts}}
										."\t".$rowdata->{$coldefined->{consume}}
										."\t".$avgcpc
										."\t".$rowdata->{$coldefined->{impression}}
										."\t".$rowdata->{$coldefined->{avgrank}}
										."\n";
								$iR++;		
							}
							
							last;#just first sheet
						}
					close $fh2;
					
}
		
		sub getHeader {
			my ( $imap, $msg_id, $count ) = @_;
		
			my $data = $imap->parse_headers( $msg_id, "From", "Subject", "Date" );
			if ( !$data ) {
				print "There isn't message which id is $msg_id./n";
				return {};
			}
		
			my $subject =
			  defined( $data->{Subject}->[0] ) ? $data->{Subject}->[0] : 'no subject';
			my $from = $data->{From}->[0];
			my $date = $data->{Date}->[0];
			return {
				"subject" => $subject,
				"from"    => $from,
				"date"    => $date,
			};
		}
		
		
		
		__END__

