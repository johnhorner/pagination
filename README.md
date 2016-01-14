# pagination

Some code I created to deal with the common problem of "page X of Y", next,
previous etc.

Probably a bit over-featured if anything.

Example script included:


	#!/usr/local/bin/perl
	use strict;
	use warnings;
	use Data::Dumper;
	use Paginate;
	my $p = Paginate->new( die_on_bad_args => 0 );
	
	# Paginate takes three values: total records, records per page, current page
	# but only the first is required.
	my $pagination = $p->Paginate( 
			total_records => 101,
			per_page      =>  10,
			current_page  =>   9 
		);
	print Dumper($pagination);

which will return the following object:

	   $p = {
			  'record_offset' => 80,
			  'record_limit' => 10,
			  'current_is_midrange' => 1,
			  'current_page' => 9,
			  'per_page' => 10,
			  'last_record_on_page' => 89,
			  'total_pages' => 11,
			  'total_records' => 101,
			  'first_record_on_page' => 80
			  'warnings' => []
			};
			
which should all be fairly self explanatory.

There are special values

* current_is_midrange
* current_is_first
* current_is_last

to make it explicit whether the page we are on is the first page, the last page
or somewhere in the middle.

# Warnings: 

The following things will generate a warning:

* If you have a small record set or a high enough `per_page` value, the page
might be both the first and the last.
* If you ask for a page which can't exist because it's greater than the total
possible pages.

# `die_on_bad_args`:

The only time it will (intentionally) die is if you call `new()` with  `die_on_bad_args => 1` 
and then you call Paginate with a current_page value which 
can't exist because it's greater than the total possible pages.