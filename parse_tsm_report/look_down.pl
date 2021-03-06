##	http://flylib.com/books/en/1.190.1.39/1/
##	http://annocpan.org/~CJM/HTML-Tree-5.909-TRIAL/lib/HTML/Tree/Scanning.pod
##	https://metacpan.org/pod/HTML::Tree
##	http://www.perlmonks.org/?node_id=1130578
##	http://search.cpan.org/dist/HTML-Tree/lib/HTML/Tree/Scanning.pod
use strict;
use warnings;
use Data::Dumper;
use HTML::TreeBuilder;

my $h = HTML::TreeBuilder->new;
$h->parse_content( do{ local $/; <DATA> } );

my @headers = 
    map @{ $_->content },
    $h->look_down( class => qr/HeaderTitle\b/ )
;

my @matched =
    map ref $_ ? @$_ : $_,
    map $_->content, $h->look_down( _tag => 'td', class => qr/Alt(Warn
+ing|Error)\b/ )
;

my @tmp =
    map[ @matched[ $_ .. $_ + @headers - 1] ],
    range( 0, $#matched, scalar(@headers) )
;

my @records;
for (@tmp) {
    my %hash;
    @hash{@headers} = @$_;
    push @records, {%hash};
}
print Dumper \@records;


sub range {grep!(($_-$_[0])%($_[2]||1)),$_[0]..$_[1]}