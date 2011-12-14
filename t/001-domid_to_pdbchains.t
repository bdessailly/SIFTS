#!/usr/bin/env perl

######################################################################
##
##    Testing script domid_to_pdbchains.
##
##    Created by Benoit H Dessailly, 2011-12-14.
##    Updated, 2011-12-14.
##
######################################################################

use strict;
use warnings;

use File::Basename;
use File::Spec;
use FindBin qw( $Bin );
use IO::File;
use Test::More tests => 1;

use lib "${Bin}/../lib";

use SIFTS;


## Test directory t/.
my $t_dir = $Bin;

## Script.
my $script = File::Spec->catfile(
    $Bin,
    '..',
    'script',
    'domid_to_pdbchains',
);

## First test with correct input file.
correct_case_test_one( $t_dir, $script );


exit;


######################################################################
## Testing script when input file is correct. 
sub correct_case_test_one {
    my $t_dir  = shift;
    my $script = shift;

    ## Input file with domain IDs.
    my $inp_domids_file = File::Spec->catfile(
        $t_dir, 'data', 'dom_test_set1', 'domids.dat',
    );
    
    ## Input file with SIFTS mapping.
    my $inp_map_file = File::Spec->catfile(
        $t_dir, 'data', 'pdb_chain_uniprot.lst',
    );
    
    ## Expected output file.
    my $exp_out_file = File::Spec->catfile(
        $t_dir, 'data', 'dom_test_set1', 'domid_pdbchains.exp.dat',
    );
    
    ## Observed output file.
    my $obs_out_file = File::Spec->catfile(
        $t_dir, 'data', 'dom_test_set1', 'domid_pdbchains.obs.dat',
    );
    
    ## Run script.
    system $script, '-i', $inp_domids_file, '-o', $obs_out_file, '-s', $inp_map_file;
    
    ## Read expected output file into string.
    my $exp_out_fh = IO::File->new( $exp_out_file, '<' );
    my $exp_out_string = <$exp_out_fh>; 
    $exp_out_fh->close;
    
    ## Read observed output file into string.
    my $obs_out_fh = IO::File->new( $obs_out_file, '<' );
    my $obs_out_string = <$obs_out_fh>;
    $obs_out_fh->close;
    
    ## Compare expected and observed output strings.
    is(
        $obs_out_string,
        $exp_out_string,
        "Observed domid-pdbchain mapping 1 as expected.",
    );
    
    ## Delete observed output file.
    unlink $obs_out_file or die "Cannot unlink $obs_out_file: $!";
}
