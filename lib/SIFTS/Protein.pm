package SIFTS::Protein;

use 5.006;
use strict;
use warnings;

=head1 NAME

SIFTS::Protein - Object representation of a protein in SIFTS.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Represents a protein in the context of the SIFTS mapping.

    use SIFTS::Protein;

    ## Create a new SIFTS Protein object.
    my $sifts_protein = SIFTS::Protein->new();
    
    ## Assign SIFTS Protein Uniprot Accession code.
    $sifts_protein->uniacc( 'P53432' );
    
    ## Assign a new SIFTS::Chain to the Protein.
    my $sifts_chain = SIFTS::Chain->new();
    $sifts_protein->add_chain( $sifts_chain );
    
    ## Set/Get a list of SIFTS::Chain objects that constitute the 
    ## protein.
    my $sifts_chain1 = SIFTS::Chain->new();
    my $sifts_chain2 = SIFTS::Chain->new();
    my @sifts_chains = ( $sifts_chain1, $sifts_chain2 );
    $sifts_protein->chains( \@sifts_chains );
    
    ## Retrieve a SIFTS::Chain with a particular Chain ID from the 
    ## SIFTS::Protein object.
    my $sifts_chain = $sifts_protein->get_chain( id => '1n3lA' );

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_protein = SIFTS::Protein->new();
    
  SIFTS::Protein::new creates a new empty SIFTS Protein object.

=cut
sub new {
}

=head2 uniacc

    $sifts_protein->uniacc( 'P53093' );
    
  SIFTS::Protein::id gets a Protein Uniprot Accession code as 
  argument for assignment. The Protein Uniprot Accession code should
  always consist of a string with 6 alphanumeric characters. Always 
  returns the uniprot accession code or undef.  

=cut
sub id {
}

=head2 add_chain

    my $sifts_chain = SIFTS::Chain->new();
    $sifts_protein->add_chain( $sifts_chain );
    
  SIFTS::Protein::add_chain gets a L<SIFTS::Chain> compliant object 
  as argument for assignment. The L<SIFTS::Chain> object will be 
  added to the current list of Chains in the SIFTS Protein. Returns 
  1 upon success, 0 upon failure. 

=cut
sub add_chain {
}

=head2 chains

    ## Assign.
    my $sifts_chain1 = SIFTS::Chain->new();
    my $sifts_chain2 = SIFTS::Chain->new();
    my @sifts_chains = ( $sifts_chain1, $sifts_chain2 );
    $sifts_protein->chains( \@sifts_chains );
    
    ## Retrieve.
    my $sifts_chains_aref = $sifts_protein->chains();
    
  SIFTS::Protein::chains gets a reference to an array of 
  L<SIFTS::Chain> compliant objects as argument for assignment. 
  Always returns a reference to an array of L<SIFTS::Chain> objects 
  contained in the Protein. The returned array may be empty.

=cut
sub chains {
}

=head2 get_chain

    my $sifts_chain = $sifts_protein->get_chain( 
        id => '1n3lA',
    );
    
  SIFTS::Protein::get_chain gets a PDB chain ID as argument and
  searches the Protein object for a L<SIFTS::Chain> object with that
  ID. Returns the L<SIFTS::Chain> object if it finds it, undef 
  otherwise.

=cut
sub get_chain {
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-protein at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-Protein>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::Protein


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-Protein>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-Protein>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-Protein>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-Protein/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::Protein
