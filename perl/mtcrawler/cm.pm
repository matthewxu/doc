#!/usr/bin/perl
package cm;
#content mapping
$version=1.0;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use FileHandle;
use Bloom::Filter;
use XML::XPath;
use XML::XPath::XMLParser;
use HTML::TreeBuilder::XPath;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Data::Dumper;
use Devel::Size qw(size total_size);
use cf;
use bs;
my $COUNT=1000000;
my $bfilter = Bloom::Filter->new( error_rate => 0.0000001, capacity => $COUNT );
my $cf;
sub new{
        my ($class, %args) = @_;
        my $self  = bless {}, $class;
        $self->{base}=$args{'base'}; 
        $self->{debug}=$args{'debug'}|| 1;
        $self->{config}=$args{'config'};
        print "cm init....\n";
		$cf=new cf(%args);
	return $self
}

sub getnewbrowser{
	my($self,@others)=@_;
	my $args={'base'=>"$self->{base}",'config'=>"$self->{config}"};

	print Dumper \$args if($self->{debug});
	my $b=new bs(%$args);
	return $b;	
}
sub setbrowser{
	my($self,$b,@others)=@_;
	unless($b){
		$b=$self->getnewbrowser();
	}
	$self->{bs}=$b;
	return 1;
}
sub getbrowser{
	my($self,$flag,@others)=@_;
	if($flag){
		my $b=$self->getnewbrowser();
		$self->{bs}=$b;
		return $b;
	}
	if(defined $self->{bs}){
		return $self->{bs};
	}else{
		my $b=$self->getnewbrowser();
		$self->{bs}=$b;
		return $b;
	}
}

sub urlcheck{
#mapping for crawling or  abandon
	my($self,$url,@others)=@_;
	my $urlmd5=md5_hex($url);
	if($filter->check($urlmd5)){
		print $url," already handle before\n";
		return 0;
	}
return 1;
}

sub urlDone{
	my($self,$url,@others)=@_;
	my $urlmd5=md5_hex($url);
	$bfilter->add($urlmd5);
	$self->saveDoneUrl($url,$urlmd5);
	return 1;
}


#############################################################################
#content data meta
#cc:channelcat
#content->{ccurlmd5}->{ccname}=""
#content->{ccurlmd5}->{detailurlmd5}->	  				{name}=""
#														{price}=""
#														{img}=""
#														{desc}=""
#														{cc}=""
##############################################################################
#page has its type, channelcat;list;detail;
#config： url-regx pagetype	json-xpath
#we should flat it, channelcat-onething-details
#xpath json meta
##############################################################################

sub digmappingv2{
	#mapping for content to save
	my($self,$url,$regxindex,$mycontent,$file,@others)=@_;

	unless($file){
		my $b=$self->getbrowser();
		$b->seturl($url);
		$file=$b->getCachedFile($url);
	}
	my $mp=$cf->getmpcfV2()->{'mpv2'};
	print Dumper $mp if($self->{debug});
	my $content=();
	my @tocrawlerurl=();
	my @datalist=();
	foreach my $regx (keys %$mp){
	#loop url regx
		print "$regx:: $mp->{$regx}->{'index'},$url:$file \n";
		if(($url=~/$regx/ &&(!$regxindex)) || ($regxindex && $regxindex eq $mp->{$regx}->{'index'} ) ) {
			print "match ======================== \n";
			my $pagetype=$mp->{$regx}->{pagetype};
			print "match $pagetype\n" if($self->{debug}); 
			#xpath instants
#			my $xp = XML::XPath->new(filename => $file);
			my $xp = HTML::TreeBuilder::XPath->new();
			$xp->parse_file($file);
			#get root xpath
			my $xpaths=$mp->{$regx}->{xpath};
			#page type: channelcat,list,detail. if detail, just single thread(proc),other, fork new thread(proc)
			
			my $pagetype=$mp->{$regx}->{pagetype};

			#data list in one page
			##############First XPath json iterator##############
			foreach my $xpath (keys %$xpaths){
				print "first xpath $xpath\n";
				#get the first node list
				my $nodeset = $xp->findnodes($xpath);
				#store one piece of onething data inhash		
				foreach my $node ($nodeset->get_nodelist) {
					#get 2 level xpath list
					my $xpathlist=$xpaths->{$xpath};
					my %datahash=();
					############seconde XPath json iterator##get same level content##################
					foreach $data(@$xpathlist){
						foreach my $xpath2(keys %$data){
							my $ntype=$data->{$xpath2};	
							my ($name,$type,$regxindex)=split '=',$ntype;
							print "xpath: $xpath2\n" if($self->{debug}); 
								my $nodevalue=$node->findvalue($xpath2);
								print "$name\t$nodevalue\t$type\n" if($self->{debug}); 
								if($type eq 'img'){
									#download and save path			
									my $bs=$self->getbrowser();
									$imgurl=$bs->fixurl($nodevalue);
									my $localpath=$bs->download($imgurl);
									$datahash{$name}=$localpath;														
								}elsif($type eq 'text'){
									#save text
									$datahash{$name}=$nodevalue;
								}elsif($type eq 'surl'){
									#sub cc url
									my  $bs=$self->getbrowser();
									$fixedurl=$bs->fixurl($nodevalue);
									$datahash{surl}=$fixedurl;
									$datahash{regxindex}=$regxindex;
									print "surl: $fixedurl\n" if($self->{debug}); 
								}elsif($type eq 'durl'){
									#detail url, this mean we are in list page.
									#todo callback or call another digmappings
									#need to do it right now or later in same piece of data
									my $bs=$self->getbrowser();
									my $fixedurl=$bs->fixurl($nodevalue);
									$datahash{durl}=$fixedurl;
									$datahash{regxindex}=$regxindex;
								}elsif($type eq 'lurl'){
									#list page url
									my $bs=$self->getbrowser();
									my $fixedurl=$bs->fixurl($nodevalue);
#									push @tocrawlerurl,$fixedurl;#crawler it later
									$datahash{lurl}=$fixedurl;	
									$datahash{regxindex}=$regxindex;
									print "lurl: $fixedurl\n" if($self->{debug}); 
								}
								elsif($type eq 'nurl'){
									#nexturl: eg. pagination "products fenye 1,2,,", just crawl it, not save the name or others
									# this mean we are in same page.
									#todo callback or call another digmappings
									my $bs=$self->getbrowser();
									my $fixedurl=$bs->fixurl($nodevalue);
									my %tmpurls=();
									$tmpurls{'nurl'}=$fixedurl;
									$tmpurls{'regxindex'}=$regxindex;
									print "nurl: $fixedurl\n" if($self->{debug}); 
									push @tocrawlerurl,\%tmpurls;#crawler it later
								}elsif($type eq 'aurl'){
									#anotherurl: eg. computerpage=>dellpage save "computer=>dell dellpageurl"
									my $bs=$self->getbrowser();
									my $fixedurl=$bs->fixurl($nodevalue);
									$datahash{aurl}=$fixedurl;	
									$datahash{regxindex}=$regxindex;
									print "aurl: $fixedurl\n" if($self->{debug}); 						                                
				                }else{
				                	$datahash{$name}=$nodevalue;
				                }	
						} 
					}
					#################################
					push @datalist, \%datahash;
				}
			}
			
		}else{
			print "not match \n";
		}
	}
	print "we get dataset:".scalar(@datalist)."\n";
	##### deal with need-to-be-handle url in datalist;
	my $urlmd5=md5_hex($url);
	$content->{url}=$url;	
	
	my @tmpdatalist=();
	foreach my $piecedata(@datalist){
		if(defined $piecedata->{surl}){#subchannel url
			print "surl:::: $piecedata->{surl}\n";
			my $return=$self->digmappingv2($piecedata->{surl});
			my $returncontent =$return->{data};
			my $cc=$piecedata->{cc};
			print "cc:$cc .................\n";
			delete $piecedata->{surl};
			delete $piecedata->{cc};
			foreach my $onedata (@$returncontent){
				my $subcc=$onedata->{cc};
				$onedata->{cc}=$cc."=>".$subcc;
				print $cc."=>".$subcc."\n" if($self->{debug});
				foreach my $d(keys %$piecedata){
					$onedata->{$d}=$piecedata->{$d};
				}
				my %savedata=%$onedata;
				push @tmpdatalist,\%savedata;
			}
			undef($return->{data});
		}
	}
	
	if(scalar(@tmpdatalist)>0){
		@datalist=@tmpdatalist;
	}
	print "we get dataset:".scalar(@datalist)."\n";


	foreach my $piecedata(@datalist){
		if(defined $piecedata->{aurl}){#another url
			print "aurl:::: $piecedata->{aurl},$piecedata->{regxindex}\n";
			my $return=$self->digmappingv2($piecedata->{aurl},$piecedata->{regxindex});
			my $returncontent =$return->{data};
			delete $piecedata->{aurl};
			delete $piecedata->{regxindex};
			foreach my $onedata (@$returncontent){
				if(defined $onedata->{'cc'}){
					$piecedata->{'cc'}.='=>'.$onedata->{'cc'};
				}
				delete $onedata->{'cc'};
				foreach my $d(keys %$onedata){
					$piecedata->{$d}=$onedata->{$d};	
				}
			}
			undef($return->{data});
		}
	}
	
	foreach my $nurls(@tocrawlerurl){#next page url
		print "nurl:::: $nurls->{nurl}\n";
		my $return=$self->digmappingv2($nurls->{nurl},$nurls->{regxindex});
		my $returncontent =$return->{data};
		foreach my $onedata (@$returncontent){
			push @datalist,$onedata;
		}
		
	}
	undef(@tocrawlerurl);
	####durl:detail url, also the last url,Last Data set , Not store in Memory###
	#TODO####Store into DB or File#########
#	@tmpdatalist=();
	foreach my $piecedata(@datalist){
		if(defined $piecedata->{durl} && !$self->isDone($piecedata->{durl})){
			print "durl::::>>>>>>>>> $piecedata->{durl},$piecedata->{regxindex}\n";
			my $return=$self->digmappingv2($piecedata->{durl},$piecedata->{regxindex});
			print "durl.... $piecedata->{durl}\n" if($self->{debug}); 
			my $returncontent =$return->{data};
			delete $piecedata->{regxindex};
			print Dumper $returncontent if($self->{debug});
			foreach my $onedata (@$returncontent){
				foreach my $d(keys %$piecedata){
					$onedata->{$d}=$piecedata->{$d};
				}
				my %savedata=%$onedata;
#				push @tmpdatalist,\%savedata;

				my	$cols=();
				if(defined $self->{cols}){
					$cols=$self->{cols};
				}
				my $linedata='detail::';
				foreach my $colname(sort {$a<=>$b} keys %savedata){
					if(defined $self->{cols}){
						unless(defined	$cols->{$colname}){
							die "defined unuint col $colname\n";
						}
					}else{
						$cols->{$colname}=1;
					}
					$linedata.="\t".$savedata{$colname};
				}
				$self->{cols}=	$cols;
				print $linedata."\n";
				$self->saveResult($linedata);
			}

			$self->urlDone($piecedata->{durl});
			undef($return->{data});
			delete $piecedata->{durl};
		}
	}
#	if(scalar(@tmpdatalist)>0){
#		@datalist=@tmpdatalist;
#		#######!!!!!!!!!!!!!!#####################
#		##Last process detail#####################
#	}
	$content->{data}=\@datalist;
	return $content;	
}


sub isDone{
	my($self,$url,@others)=@_;
	my $bfilterurls=$self->getDoneUrl();
	if($bfilterurls->check(md5_hex($url))){
		return 1;
	}
	return 0;
}




sub saveResult{
	my($self,$result,@others)=@_;
    my $resultfile=$cf->{'result'}.$self->{batchid};
    print $resultfile."\n";
    my $fh;
	if(defined $self->{resulthandle}) {
		$fh= $self->{resulthandle};
	}else{
		$fh=new FileHandle();
        $fh->open(">> $resultfile") || die "$resultfile fail\n";
		$fh->autoflush(1);       
	 	$self->{resulthandle}=$fh;
	}
	print $fh "$result\n";
}



sub saveDoneUrl{
	my($self,$url,$key,@others)=@_;
    my $urltofile=$cf->{'urltofile'}.$self->{batchid};
    print $urltofile."\n";
    my $fh;
	if(defined $self->{doneurlhandle}) {
		$fh= $self->{doneurlhandle};
	}else{
		$fh=new FileHandle();
        $fh->open(">> $urltofile") || die "$urltofile fail\n";
		$fh->autoflush(1);       
	 	$self->{doneurlhandle}=$fh;
	}
	print $fh "$key\t$url\n";
	$self->getDoneUrl()->add($key);
}
sub getDoneUrl{
    my($self,@others)=@_;
	if(defined $self->{bfilter}){
		return $bfilter;
	}        
    my $urltofile=$cf->{'urltofile'}.$self->{batchid};
    unless(-e $urltofile) {return $bfilter};
    my $fh=new FileHandle();
    $fh->open($urltofile) || die "$urltofile fail\n";
	while(my $l=<$fh>){
		chomp($l);
		my($md5,$url)=split '\t',$l;
		$bfilter->add($md5);
	}	
	close $fh;
	$self->{bfilter}=$bfilter;
	return $bfilter;
} 

sub print_size{
	my($self,$date,$name,@others)=@_;
	print "$name hash memory bytes>>>>>>>>>>>>:".size($data)."\n";
	print "$name total memory bytes>>>>>>>>>>>>:".total_size($data)."\n";
	print "$name data memory bytes>>>>>>>>>>>>:".(total_size($data)-size($data))."\n";
}
sub _destroy{
	my($self,@others)=@_;
	if(defined $self->{doneurlhandle}){
		close $self->{doneurlhandle};
		undef $self->{doneurlhandle};
	}
	if(defined $self->{resulthandle}){
		close $self->{resulthandle};
		undef $self->{resulthandle};
	}
}

1;
