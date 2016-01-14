package Paginate;
use strict;
use warnings;
use POSIX qw(ceil);

sub new {
    my $class       = shift;
    my %preferences = @_;
    my $self        = {};
    foreach ( keys(%preferences) ) { $self->{$_} = $preferences{$_} }
    return bless( $self, $class );
}

sub Paginate {
    my $self = shift();
    my %args = @_;
    my $p    = ();
    $p->{warnings}      = [];
    $p->{total_records} = $args{'total_records'};
    $p->{per_page}      = defined( $args{'per_page'} ) ? $args{'per_page'} : 10;
    $p->{current_page} =
      defined( $args{'current_page'} ) ? $args{'current_page'} : 1;
    $p->{total_pages} = ceil( $args{'total_records'} / $p->{per_page} );

    if ( $p->{total_records} < $p->{per_page} ) {
        push(
            @{ $p->{warnings} },
            'Per-page value is less than the total number of records.'
        );
    }

    if ( $p->{current_page} > $p->{total_pages} ) {
        if ( $self->{die_on_bad_args} ) {
            die("Error: current page greater than total pages");
        } else {
            push(
                @{ $p->{warnings} },
                'Current page value is greater than total pages.'
            );
        }
    }
    $p->{record_offset}        = ( $p->{current_page} - 1 ) * $p->{per_page};
    $p->{first_record_on_page} = $p->{record_offset};
    $p->{last_record_on_page}  = $p->{record_offset} + ( $p->{per_page} - 1 );
    if ( $p->{last_record_on_page} >= $p->{total_records} ) {
        $p->{last_record_on_page} = ( $p->{total_records} - 1 );
    }
    $p->{record_limit} = $args{'per_page'};
    if ( $p->{current_page} == $p->{total_pages} ) {
        $p->{current_is_last} = 1;
    }
    if ( $p->{current_page} == 1 ) {
        $p->{current_is_first} = 1;
    }
    if ( ( $p->{current_is_first} ) && ( $p->{current_is_last} ) ) {
        push( @{ $p->{warnings} }, 'Page is both first and last page.' );
    }

    if ( !( $p->{current_is_first} ) && !( $p->{current_is_last} ) ) {
        $p->{current_is_midrange} = 1;
    }
    return $p;
}
1;


