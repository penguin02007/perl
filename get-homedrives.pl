
-pod
Get home drives and list top level directories with specific keywords:
Query base directory and store home drives into array
Loop over each home drive and list top level directories with specific keyword
save each result to a text file
-cut
use v5.012;	# use bare readdir in while loop
use File::DosGlob 'glob';

my $basedir = shift @ARGV;
if (not defined $basedir) {$basedir = 'C:\Users'};
opendir (my $bdh1, $basedir) or die $!;
#my $re1 = 'Desktop';
#my $re2 = '*.txt';
##$re2 = '^d\s?dri?ve?\w?$'
#@dots = grep { /^\./ && -f "$some_dir/$_" } readdir($dh);

my ($homedir, @homedirs);

while (readdir $bdh1) {
	next unless $_ =~ m/(kze|cherie)/i;
	push @homedirs, $_;
}
closedir $bdh1;

my $i = 1;
foreach my $homedir (@homedirs){
	my $fqhd = "$basedir\\$homedir";
	say "working on $fqhd - $i";
	opendir (my $hfh, $fqhd) or die $!;
	my @hz = grep {!/\.dat\. && -d/} (readdir $hfh);
	say @hz;
	closedir $hfh;
	$i++;
}
#for (1 .. $#homedirs ) { say $_ ; }
exit 0;