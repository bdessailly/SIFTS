package SIFTS::Residue;

use 5.006;
use strict;
use warnings;

=head1 NAME

SIFTS::Residue - Object representation of a protein residue in SIFTS.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Represents a protein residue in the context of the SIFTS mapping.

    use SIFTS::Residue;

    ## Create new residue object.
    my $sifts_residue = SIFTS::Residue->new();
    
    ## Set/Get SEQRES position number.
    $sifts_residue->pdb_seqres_posn( '153' );
    
    ## Set/Get PDB position number.
    $sifts_residue->pdb_crd_posn( '153' );
    
    ## Set/Get UniProt position number.
    $sifts_residue->uniprot_posn( '155' );

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_residue = SIFTS::Residue->new();
    
  SIFTS::Residue::new creates a new empty SIFTS Residue object.

=cut
sub new {
}

=head2 pdb_seqres_posn

    ## Set.
    $sifts_residue->pdb_seqres_posn( '153' );
    
    ## Get.
    my $pdb_seqres_posn = $sifts_residue->pdb_seqres_posn();

  SIFTS::Residue::pdb_seqres_posn gets a PDB seqres position as 
  argument for assignment. Always returns the PDB seqres position or 
  undef.

=cut
sub pdb_seqres_posn {
}

=head2 pdb_crd_posn

    ## Set.
    $sifts_residue->pdb_crd_posn( '153' );
    
    ## Get.
    my $pdb_crd_posn = $sifts_residue->pdb_crd_posn();
    
  SIFTS::Residue::pdb_crd_posn gets a position from the coordinates 
  section of a PDB entry as argument for assignment. Always returns 
  the PDB coordinate position or undef.  

=cut
sub pdb_crd_posn {
}

=head2 uniprot_posn

    ## Set.
    $sifts_residue->uniprot_posn( '155' );
    
    ## Get.
    my $uniprot_posn = $sifts_residue->uniprot_posn();
    
  SIFTS::Residue::uniprot_posn gets a Uniprot position as argument
  for assignment. Always returns the Uniprot position or undef.

=cut
sub uniprot_posn {
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-residue at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-Residue>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::Residue


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-Residue>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-Residue>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-Residue>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-Residue/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::Residue
