#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::Residue.
##
##    Created by Benoit H Dessailly, 2012-01-06.
##    Updated, 2012-01-06.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use FindBin qw( $Bin );
use Test::More tests => 6;

use lib "${Bin}/../lib";

use SIFTS::Residue;


## Test directory t/.
my $t_dir = $Bin;

## Test empty SIFTS::Residue object.
test_empty_sifts_residue();

## Test simple SIFTS::Residue object.
test_simple_sifts_residue();

exit;


######################################################################
## Test properties of an empty SIFTS::Residue object.
sub test_empty_sifts_residue {
    my $sifts_residue = SIFTS::Residue->new();
    
    ok(
        defined $sifts_residue,
        'SIFTS residue object is defined.',
    );
    
    isa_ok(
        $sifts_residue, 'SIFTS::Residue',
    );
    
    can_ok(
        $sifts_residue, qw( pdb_seqres_posn pdb_crd_posn uniprot_posn ),
    );
}

######################################################################
## Test properties of a simple SIFTS::Residue object.
sub test_simple_sifts_residue {
    my $sifts_residue = SIFTS::Residue->new();
    
    ## Set attributes.
    $sifts_residue->pdb_seqres_posn( '153' );
    $sifts_residue->pdb_crd_posn( '153' );
    $sifts_residue->uniprot_posn( '155' );
    
    ## Get attributes.
    my $ret_pdb_seqres_posn = $sifts_residue->pdb_seqres_posn();
    my $ret_pdb_crd_posn    = $sifts_residue->pdb_crd_posn();
    my $ret_uniprot_posn    = $sifts_residue->uniprot_posn();
    
    ## Check attributes.
    is(
        $ret_pdb_seqres_posn,
        '153',
        'pdb_seqres_posn as expected.',
    );
    is(
        $ret_pdb_crd_posn,
        '153',
        'pdb_crd_posn as expected.',
    );
    is(
        $ret_uniprot_posn,
        '155',
        'uniprot_posn as expected.',
    );
}