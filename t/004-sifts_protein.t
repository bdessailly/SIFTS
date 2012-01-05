#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::Protein.
##
##    Created by Benoit H Dessailly, 2012-01-05.
##    Updated, 2012-01-05.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use FindBin qw( $Bin );
use Test::More tests => 11;

use lib "${Bin}/../lib";

use SIFTS::Protein;


## Test directory t/.
my $t_dir = $Bin;

## Test empty SIFTS::Protein object.
test_empty_sifts_protein();

## Test SIFTS::Protein behaviour with empty SIFTS::Chain objects.
test_emptychain_sifts_protein();


exit;


######################################################################
## Test properties of an empty SIFTS::Protein object.
sub test_empty_sifts_protein {
    my $sifts_protein = SIFTS::Protein->new();
    
    ok(
        defined $sifts_protein,
        'SIFTS protein object is defined.',
    );
    
    isa_ok(
        $sifts_protein, 'SIFTS::Protein',
    );
    
    can_ok(
        $sifts_protein, qw( uniacc add_chain chains get_chain ),
    );
}

######################################################################
## Test SIFTS::Protein object with empty SIFTS::Chain objects.
sub test_emptychain_sifts_protein {
    
    ## Create first dummy chain object.
    my $sifts_chain1 = SIFTS::Chain->new();
    $sifts_chain1->pdbchainid( '1n3lA' );
    
    ## Create SIFTS protein object.
    my $sifts_protein = SIFTS::Protein->new();
    
    ## Load chain object into protein object.
    $sifts_protein->add_chain( $sifts_chain1 );
    
    ## Is method get_chain working?
    my $returned_sifts_chain 
        = $sifts_protein->get_chain( id => '1n3lA' );
    ok(
        defined $returned_sifts_chain,
        'Chain object was found in protein.',
    );
    isa_ok(
        $returned_sifts_chain,
        'SIFTS::Chain',
    );
    can_ok(
        $returned_sifts_chain,
        qw( pdbchainid add_segment segments get_segment ),
    );
    
    ## Is method chains working?
    my $sifts_chains_aref = $sifts_protein->chains();
    is(
        scalar @{ $sifts_chains_aref },
        1,
        'Method chains returns expected array reference.',
    );
    
    ## Create second dummy chain object.
    my $sifts_chain2 = SIFTS::Chain->new();
    $sifts_chain2->pdbchainid( '1a2pA' );
    
    ## Add new chain object to protein object.
    $sifts_protein->add_chain( $sifts_chain2 );
    
    ## Has the new chain been loaded into the protein object.
    my $returned_sifts_chain2
        = $sifts_protein->get_chain( id => '1a2pA' );
    ok(
        defined $returned_sifts_chain2,
        'New chain object was found in protein.',
    );
    isa_ok(
        $returned_sifts_chain2,
        'SIFTS::Chain',
    );
    can_ok(
        $returned_sifts_chain2,
        qw( pdbchainid add_segment segments get_segment ),
    );
    
    ## Testing method chains with two chains in the protein object.
    my $sifts_2chains_aref = $sifts_protein->chains();
    is(
        scalar @{ $sifts_2chains_aref },
        2,
        'Method chains returns array ref with 2 chains.'
    );
}