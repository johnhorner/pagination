#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Paginate;
my $p = Paginate->new( { die_on_bad_args => 0 } );
my $pagination = $p->Paginate( 9, 10, 1 );
print Dumper($pagination);

