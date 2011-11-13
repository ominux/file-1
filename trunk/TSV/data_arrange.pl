#! /home/gnu/bin/perl
# measurement flow
# input format input.mt0 output.mt0 -h
# $"="\t";
use strict;
use warnings;
use File::Path;

	
my @data;
my $file=shift(@ARGV);
my $write=shift(@ARGV);
my $headline=0;
if ($#ARGV != -1 && $ARGV[0] =~ /^-h$/ )
{
	$headline=1;
}

#my $n=shift(@ARGV);
#done: parameter setting

open HEADER, "$file" or die "Cannot open $file to read $!\n";
@data = <HEADER>;
close (HEADER);

my $top="$data[0]  \t$data[1]";
$top =~ s/\n//g;
my $hd='';
my $n=0;
my $ii=2;
while ($data[$ii-1] !~ /alter/)
{
	$hd=$hd.$data[$ii++];
	$n++;
}
$hd =~ s/\n//g;
$hd =~ s/^\s|\s$//g;
my @hhh=split(/\s+/,$hd);
pop(@hhh);

my $hhout=&printline(@hhh);

my $ct=1;
my $temp='';
my @output;

foreach my $line (@data[$ii..$#data])
{
	my $dt=$line;
	$temp=$temp.$dt;
	if ($ct == $n)
	{	
		push(@output, $temp);
		$temp='';
		$ct=0;
	}
	$ct=$ct+1;	
}

foreach my $line (@output)
{
	my $aa=$line;
	$aa =~ s/\n//g;
	$aa =~ s/^\s*|\s*$//g;
	$aa =~ s/failed/1e5/g;
	my @aaa=split(/\s+/, $aa);
	pop(@aaa);
	if ($#aaa != $#hhh)	{	print "Error : number of items not match with header! $aa\n";	}
	$line=&printline(@aaa);
}

if ($headline)
{
	unshift(@output, "$hhout");
	unshift(@output, "$top\n");
}

open FILE, ">$write" or die "Cannot open $write to write $!\n";
print FILE @output;
close (FILE);
# print "Output $write done!\n";

sub printline
{
	my $out='';
	foreach (@_)
	{
		$out=$out.sprintf("%-16s","$_");
	}
	return("$out\n");
}