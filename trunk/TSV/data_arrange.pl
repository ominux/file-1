#! /usr/bin/perl
# measurement flow
# data_process.pl input_file output_file

use strict;
use warnings;
use File::Path;

my @data;


my $file=shift(@ARGV);
my $write=shift(@ARGV);
#my $n=shift(@ARGV);
#done: parameter setting

my $dir = `pwd`;
chop($dir);
my $result="${dir}/${file}";
open HEADER, "$result" or die "Cannot open $result to read $!\n";
@data = <HEADER>;
close (HEADER);

#for (my $ct=0; $ct<$n; $ct++)
my $n=-1;
while (!($data[0] =~ /alter/))
{
	shift(@data);
	$n++;
}
shift(@data);

my $ct=1;
my $temp;
my @output;


foreach my $line (@data)
{
	my $dt=$line;
	chop($dt);
	$temp=$temp.$dt;
	
	if ($ct == $n)
	{	
		$temp=$temp."\n";
		push(@output, $temp);
		$temp='';
		$ct=0;
	}
	$ct=$ct+1;	
}

foreach my $line (@output)
{
	my $aa=$line;
	$aa =~ s/^(\s+)//g;
	$aa =~ s/(\s+)/\t/g;
	$aa =~ s/failed/1e2/g;
	my @aaa=split(/\t/, $aa);
	pop(@aaa);
	pop(@aaa);
	$"="\t";
	$aa="@aaa";
	$aa=$aa."\n";
	$line=$aa;
}



open FILE, ">$write" or die "Cannot open $write to write $!\n";
print FILE @output;
close (FILE);
print "Output $write done!\n";

