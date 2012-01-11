#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::Segment.
##
##    Created by Benoit H Dessailly, 2012-01-06.
##    Updated, 2012-01-06.
##    Updated, 2012-01-11.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use FindBin qw( $Bin );
use Test::More tests => 10;

use lib "${Bin}/../lib";

use SIFTS::Segment;
use SIFTS::Residue;


## Test directory t/.
my $t_dir = $Bin;

## Test empty SIFTS::Segment object.
test_empty_sifts_segment();

## Test SIFTS::Segment object behaviour with simple Start and Stop 
## SIFTS::Residue objects.
test_simple_sifts_segment();

exit;


######################################################################
## Test properties of an empty SIFTS::Segment object.
sub test_empty_sifts_segment {
    my $sifts_segment = SIFTS::Segment->new();
    
    ok(
        defined $sifts_segment,
        'SIFTS segment object is defined.',
    );
    
    isa_ok(
        $sifts_segment, 'SIFTS::Segment',
    );
    
    can_ok(
        $sifts_segment, qw( id start_residue stop_residue ),
    );
}

######################################################################
## Test a simple SIFTS::Segment object with simple Start and Stop 
## SIFTS::Residue objects.
sub test_simple_sifts_segment {
    
    ## Create Start residue object.
    my $start_sifts_res = SIFTS::Residue->new();
    $start_sifts_res->pdb_seqres_posn( '2' );
    $start_sifts_res->pdb_crd_posn( '2' );
    $start_sifts_res->uniprot_posn( '3' );
    
    ## Create Stop residue object.
    my $stop_sifts_res = SIFTS::Residue->new();
    $stop_sifts_res->pdb_seqres_posn( '153' );
    $stop_sifts_res->pdb_crd_posn( '153' );
    $stop_sifts_res->uniprot_posn( '154' );
    
    ## Create Segment object.
    my $sifts_segment = SIFTS::Segment->new();
    $sifts_segment->id( '1n3lA_2_142' );
    
    ## Check segment id.
    my $segment_id = $sifts_segment->id();
    is(
        $segment_id,
        '1n3lA_2_142',
        'Segment ID was properly loaded in Segment object.',
    );
    
    ## Load Start residue into Segment object.
    $sifts_segment->start_residue( $start_sifts_res );
    
    ## Load Stop residue into Segment object.
    $sifts_segment->stop_residue( $stop_sifts_res );
    
    ## Check that Start residue was properly loaded and can be
    ## retrieved from the Segment object.
    my $ret_start_sifts_res = $sifts_segment->start_residue();
    ok(
        defined $ret_start_sifts_res,
        'Start residue object was found in Segment.',
    );
    isa_ok(
        $ret_start_sifts_res,
        'SIFTS::Residue',
    );
    can_ok(
        $ret_start_sifts_res,
        qw( pdb_seqres_posn pdb_crd_posn uniprot_posn ),
    );
    
    ## Check that Stop residue was properly loaded and can be 
    ## retrieved from the Segment object.
    my $ret_stop_sifts_res = $sifts_segment->stop_residue();
    ok(
        defined $ret_stop_sifts_res,
        'Stop residue object was found in Segment.',
    );
    isa(
        $ret_stop_sifts_res,
        'SIFTS::Residue',
    );
    can_ok(
        $ret_stop_sifts_res,
        qw( pdb_seqres_posn pdb_crd_posn uniprot_posn ),
    );
}