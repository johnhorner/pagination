package Paginate;
use POSIX qw(ceil);
use Data::Dumper::Simple;

sub new {
    my $class       = shift;
    my $preferences = shift;
    my $self        = {};
    foreach ( keys( %{$preferences} ) ) { $self->{$_} = $preferences->{$_}; }
    return bless( $self, $class );
}

sub Paginate {
    my $self = shift();
    my ( $total_records, $per_page, $current_page ) = @_;
    my $p = ();
    $p->{total_records} = $total_records;
    $p->{per_page}      = defined($per_page) ? $per_page : 10;
    $p->{current_page}  = defined($current_page) ? $current_page : 1;
    $p->{total_pages}   = ceil( $total_records / $p->{per_page} );
    if ( $self->{die_on_bad_args} ) {

        if ( $p->{current_page} > $p->{total_pages} ) {
            die("Error: current page greater than total pages");
        }
    }
    $p->{record_offset}        = ( $p->{current_page} - 1 ) * $p->{per_page};
    $p->{first_record_on_page} = $p->{record_offset};
    $p->{last_record_on_page}  = $p->{record_offset} + ( $p->{per_page} - 1 );
    if ( $p->{last_record_on_page} >= $p->{total_records} ) {
        $p->{last_record_on_page} = ($p->{total_records} - 1);
    }
    $p->{record_limit} = $per_page;
    if ( $p->{current_page} == $p->{total_pages} ) {
        $p->{current_is_last} = 1;
    }
    elsif ( $p->{current_page} == 1 ) { $p->{current_is_first}    = 1; }
    else                              { $p->{current_is_midrange} = 1; }
    return $p;
}
1;

