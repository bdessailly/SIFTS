#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::Chain.
##
##    Created by Benoit H Dessailly, 2012-01-06.
##    Updated, 2012-01-06.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use FindBin qw( $Bin );
use Test::More tests => 11;

use lib "${Bin}/../lib";

use SIFTS::Chain;


## Test directory t/.
my $t_dir = $Bin;

## Test empty SIFTS::Chain object.
test_empty_sifts_chain();

## Test SIFTS::Chain behaviour with empty SIFTS::Segment objects.
test_emptysegment_sifts_chain();


exit;


######################################################################
## Test properties of an empty SIFTS::Chain object.
sub test_empty_sifts_chain {
    my $sifts_chain = SIFTS::Chain->new();
    
    ok(
        defined $sifts_chain,
        'SIFTS chain object is defined.',
    );
    
    isa_ok(
        $sifts_chain, 'SIFTS::Chain',
    );
    
    can_ok(
        $sifts_chain, qw( pdbchainid add_segment segments get_segment ),
    );
}

######################################################################
## Test SIFTS::Chain object with empty SIFTS::Segment objects.
sub test_emptysegment_sifts_chain {
    
    ## Create first dummy segment object.
    my $sifts_segment1 = SIFTS::Segment->new();
    $sifts_segment1->id( '1n3lA_1_115' );
    
    ## Create SIFTS chain object.
    my $sifts_chain = SIFTS::Chain->new();
    
    ## Load segment object into chain object.
    $sifts_chain->add_segment( $sifts_segment1 );
    
    ## Is method get_segment working?
    my $returned_sifts_segment 
        = $sifts_chain->get_segment( id => '1n3lA_1_115' );
    ok(
        defined $returned_sifts_segment,
        'Segment object was found in chain.',
    );
    isa_ok(
        $returned_sifts_segment,
        'SIFTS::Segment',
    );
    can_ok(
        $returned_sifts_segment,
        qw( id start_residue stop_residue ),
    );
    
    ## Is method segments working?
    my $sifts_segments_aref = $sifts_chain->segments();
    is(
        scalar @{ $sifts_segments_aref },
        1,
        'Method segments returns expected array reference.',
    );
    
    ## Create second dummy segment object.
    my $sifts_segment2 = SIFTS::Segment->new();
    $sifts_segment2->id( '1a2pA_2_108' );
    
    ## Add new segment object to chain object.
    $sifts_chain->add_segment( $sifts_segment2 );
    
    ## Has the new segment been loaded into the chain object.
    my $returned_sifts_segment2
        = $sifts_chain->get_segment( id => '1a2pA_2_108' );
    ok(
        defined $returned_sifts_segment2,
        'New segment object was found in chain.',
    );
    isa_ok(
        $returned_sifts_segment2,
        'SIFTS::Segment',
    );
    can_ok(
        $returned_sifts_segment2,
        qw( id start_residue stop_residue ),
    );
    
    ## Testing method segments with two segments in the chain object.
    my $sifts_2segments_aref = $sifts_chain->segments();
    is(
        scalar @{ $sifts_2segments_aref },
        2,
        'Method segments returns array ref with 2 segments.'
    );
}