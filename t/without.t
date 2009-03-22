#!perl
use strict;
use warnings;

use Module::Release;
use Test::More tests => 6;

use Test::Without::Module qw( Test::Prereq Module::CPANTS::Analyse );


my @tuples = (
	[ qw( Module::Release::Prereq   check_prereqs  ) ],
	[ qw( Module::Release::Kwalitee check_kwalitee ) ],
	);

foreach my $tuple ( @tuples )
	{
	my( $module, $method ) = @$tuple;
	
	my $rc = eval "{ package Module::Release; require $module; $module\->import  }";
	ok( defined $rc, "Loading $module succeeds" );
	
	my $release = Module::Release->new( quiet => 1 );
	can_ok( $release, $method );
	
	eval { $release->$method };
	my $at = $@;
	
	like( $at, qr/You need/i, "Gets right error message" );
	}



