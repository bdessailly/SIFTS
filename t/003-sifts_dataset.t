#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::Dataset.
##
##    Created by Benoit H Dessailly, 2011-12-15.
##    Updated, 2011-12-15.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use FindBin qw( $Bin );
use Test::More tests => 11;

use lib "${Bin}/../lib";

use SIFTS::Dataset;


## Test directory t/.
my $t_dir = $Bin;

## Test empty object.
test_empty_sifts_dataset( );

## Test SIFTS::Dataset behaviour with empty SIFTS::Protein objects.
test_emptyprotein_sifts_dataset( );

exit;


######################################################################
## Test basic properties of empty SIFTS::Dataset object.
sub test_empty_sifts_dataset {
    my $sifts_dataset = SIFTS::Dataset->new();
    
    ok(
        defined $sifts_dataset,
        'SIFTS dataset object is defined.',
    );
    
    isa_ok(
        $sifts_dataset, 'SIFTS::Dataset',
    );
    
    can_ok(
        $sifts_dataset, qw( add_protein proteins get_protein ),
    );
}

######################################################################
## Test SIFTS::Dataset object with empty SIFTS::Protein objects.
sub test_emptyprotein_sifts_dataset {
    
    ## Create dummy protein object.
    my $sifts_protein1 = SIFTS::Protein->new();
    $sifts_protein1->uniacc( 'P43209' );
    
    ## Create dataset object.
    my $sifts_dataset = SIFTS::Dataset->new();
    
    ## Load protein object into dataset object.
    $sifts_dataset->add_protein( $sifts_protein1 );
    
    ## Is method get_protein working?
    my $returned_sifts_protein = $sifts_dataset->get_protein( 
        uniacc => 'P43209' 
    );
    ok(
        defined $returned_sifts_protein,
        'Protein object was found in Dataset.'
    );
    isa_ok(
        $returned_sifts_protein, 'SIFTS::Protein',
    );
    can_ok(
        $returned_sifts_protein, 
        qw( uniacc add_chain chains get_chain ),
    );
    
    ## Is method proteins working?
    my $sifts_proteins_aref = $sifts_dataset->proteins();
    is(
        scalar @{ $sifts_proteins_aref },
        1,
        'Method proteins returns expected array reference.'
    );
    
    ## Create a second dummy protein object.
    my $sifts_protein2 = SIFTS::Protein->new();
    $sifts_protein2->uniacc( 'O98123' );
    
    ## Add new protein object to dataset object.
    $sifts_dataset->add_protein( $sifts_protein2 );
    
    ## Has new protein object been loaded in dataset?
    my $returned_sifts_protein2 = $sifts_dataset->get_protein(
        uniacc => 'O98123',
    );
    ok(
        defined $returned_sifts_protein2,
        'New protein object was found in Dataset.',
    );
    isa_ok(
        $returned_sifts_protein2, 'SIFTS::Protein',
    );
    can_ok(
        $returned_sifts_protein2, 
        qw( uniacc add_chain chains get_chain ),
    );
    
    my $sifts_2proteins_aref = $sifts_dataset->proteins();
    is(
        scalar @{ $sifts_2proteins_aref },
        2,
        'Method proteins returns array ref with 2 proteins.'
    );
}