#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Paginate;
my $p = Paginate->new( die_on_bad_args => 0 );
my $pagination =
  $p->Paginate( total_records => 101, per_page => 10, current_page => 9 );
print Dumper($pagination);


