package SIFTS::IO::Text::PdbUniprot;

use 5.006;
use strict;
use warnings;

use Carp;
use IO::File;

use SIFTS::Dataset;
use SIFTS::Protein;
use SIFTS::Chain;
use SIFTS::Segment;
use SIFTS::Residue;

=head1 NAME

SIFTS::IO::Text::PdbUniprot - Parser for text file 
'pdb_chain_uniprot.lst' mapping PDB chain IDs to Uniprot accession 
codes as provided by SIFTS 

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module implements a parser for file 'pdb_chain_uniprot.list' 
provided by SIFTS, which maps PDB chain IDs to Uniprot accession 
codes.

    use SIFTS::IO::Text::PdbUniprot;

    my $sifts_text_parser = SIFTS::IO::Text::PdbUniprot->new();

    my $sifts_dataset = $sifts_text_parser->read(
        mapping_file => 'pdb_chain_uniprot.lst',
    );

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_parser = SIFTS::IO::Text::PdbUniprot->new();
    
  SIFTS::IO::Text::PdbUniprot::new creates a new empty object to 
  represent a parser for SIFTS pdbchain to uniprot mapping text file.

=cut
sub new {
    my $class = shift;

    my $self = {};
    
    bless( $self, $class );

    return $self;
}

=head2 read

    my $sifts_dataset = $sifts_parser->read(
        mapping_file => 'pdb_chain_uniprot.lst',
    );

  SIFTS::IO::Text::PdbUniprot::read reads the SIFTS pdbchain-to-
  uniprot mapping text file and creates an object representation of 
  the mapping.

=cut
sub read {
    my $self = shift;
    my %arg  = @_;

    ## Check arguments.
    confess "Missing mandatory argument 'mapping_file'.\n"
        unless ( exists $arg{'mapping_file'} );

    ## Create a new SIFTS::Dataset object.
    my $sifts_dataset = SIFTS::Dataset->new();

    ## Read file.
    my $fh_mapping = IO::File->new( $arg{'mapping_file'}, '<' );
    while ( my $line = $fh_mapping->getline ) {
        chomp $line;

        ## Skip header line.
        if ( $line =~ /^PDB\tCHAIN\tSP_PRIMARY/ ) {
            next;
        }

        ## Data lines.
        my @data_items = split (/\s+/, $line);
        my $pdb        = $data_items[0];
        my $chainid    = $data_items[1];
        my $uniacc     = $data_items[2];
        my $seqres_beg = $data_items[3];
        my $seqres_end = $data_items[4];
        my $pdb_beg    = $data_items[5];
        my $pdb_end    = $data_items[6];
        my $sp_beg     = $data_items[7];
        my $sp_end     = $data_items[8];

        ## Create new segment.
        my $sifts_segment = SIFTS::Segment->new();
        $sifts_segment->id( 
            "${pdb}${chainid}_${seqres_beg}_${seqres_end}" 
        );

        ## Create segment start residue.
        my $sifts_start_residue = SIFTS::Residue->new();
        $sifts_start_residue->pdb_seqres_posn( $seqres_beg );
        $sifts_start_residue->pdb_crd_posn( $pdb_beg );
        $sifts_start_residue->uniprot_posn( $sp_beg );
        $sifts_segment->start_residue( $sifts_start_residue );

        ## Create segment stop residue.
        my $sifts_stop_residue = SIFTS::Residue->new();
        $sifts_stop_residue->pdb_seqres_posn( $seqres_end );
        $sifts_stop_residue->pdb_crd_posn( $pdb_end );
        $sifts_stop_residue->uniprot_posn( $sp_end );
        $sifts_segment->stop_residue( $sifts_stop_residue );
        
        ## Retrieve any existing protein object with current line 
        ## uniprot accession already exists from SIFTS::Dataset.
        my $existing_sifts_protein = $sifts_dataset->get_protein( 
            uniacc => $uniacc 
        );
        
        ## If protein object already exists in dataset.
        if ( defined $existing_sifts_protein ) {
            
            ## Retrieve any existing protein chain object with 
            ## current line properties from existing protein object.
            my $existing_sifts_chain 
                = $existing_sifts_protein->get_chain(
                    pdbchainid => "${pdb}${chainid}",
                );
            
            ## If chain object already exists in protein object.
            if ( defined $existing_sifts_chain ) {
                
                ## Add new segment.
                $existing_sifts_chain->add_segment( $sifts_segment );
            }

            ## If chain object does not exist in protein object.
            else {
                
                ## Create new chain.
                my $sifts_chain = SIFTS::Chain->new();
                $sifts_chain->pdbchainid( "${pdb}${chainid}" );
                $sifts_chain->add_segment( $sifts_segment );
                
                ## Add new chain to existing protein object.
                $existing_sifts_protein->add_chain( $sifts_chain );
            } 
        }

        ## If protein object does not exist in dataset. 
        else {
            
            ## Create new chain.
            my $sifts_chain = SIFTS::Chain->new();
            $sifts_chain->pdbchainid( "${pdb}${chainid}" );
            $sifts_chain->add_segment( $sifts_segment );
            
            ## Create new protein object.
            my $new_sifts_protein = SIFTS::Protein->new();
            $new_sifts_protein->uniacc( $uniacc );
            $new_sifts_protein->add_chain( $sifts_chain );
            
            ## Add new protein to existing dataset object.
            $sifts_dataset->add_protein( $new_sifts_protein );
        }
    }
    $fh_mapping->close;
    
    return $sifts_dataset;
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-io-text-pdbuniprot at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-IO-Text-PdbUniprot>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::IO::Text::PdbUniprot


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-IO-Text-PdbUniprot>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-IO-Text-PdbUniprot>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-IO-Text-PdbUniprot>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-IO-Text-PdbUniprot/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::IO::Text::PdbUniprot
