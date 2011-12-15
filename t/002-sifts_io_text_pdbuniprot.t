#!/usr/bin/env perl

######################################################################
##
##    Testing methods of class SIFTS::IO::Text::PdbUniprot.
##
##    Created by Benoit H Dessailly, 2011-12-15.
##    Updated, 2011-12-15.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use File::Spec;
use FindBin qw( $Bin );
use Test::More tests => 15;

use lib "${Bin}/../lib";

use SIFTS::Dataset;
use SIFTS::IO::Text::PdbUniprot;


## Test directory t/.
my $t_dir = $Bin;

## Test parser object creation.
my $sifts_text_parser = SIFTS::IO::Text::PdbUniprot->new();
ok(
    defined $sifts_text_parser, 'SIFTS Text parser is created.',
);
isa_ok(
    $sifts_text_parser, 'SIFTS::IO::Text::PdbUniprot',
);
can_ok(
    $sifts_text_parser, qw( read ),
);

## Test parser read method with standard pdb_chain_uniprot file.
test_read_standard_one(
    $sifts_text_parser,
    $t_dir,
);

exit;


######################################################################
## Test method SIFTS::IO::Text::PdbUniprot::read with a correctly
## formatted pdb_chain_uniprot.lst file.
sub test_read_standard_one {
    my $sifts_text_parser = shift;
    my $t_dir             = shift;

    ## Data file.
    my $mapping_file = File::Spec->catfile(
        $t_dir,
        'data', 
        'pdb_chain_uniprot.lst',
    );

    ## Read file.
    my $sifts_dataset = $sifts_text_parser->read(
        mapping_file => $mapping_file,
    );

    ## Check returned dataset object has expected class.
    ok(
        defined $sifts_dataset, 'SIFTS dataset object created.',
    );
    isa_ok(
        $sifts_dataset, 'SIFTS::Dataset',
    );
    can_ok(
        $sifts_dataset, qw( add_protein proteins get_protein ),
    );

    ## Check returned dataset object has expected contents.
    my $sifts_proteins_aref = $sifts_dataset->proteins();
    is(
        scalar @{ $sifts_proteins_aref },
        8,
        'Number of proteins as expected in SIFTS dataset object.',
    );
    for my $sifts_protein ( @{ $sifts_proteins_aref } ) {
        isa_ok(
            $sifts_protein, 'SIFTS::Protein',
        );
    }
}
