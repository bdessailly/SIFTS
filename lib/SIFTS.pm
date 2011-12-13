package SIFTS;

use 5.006;
use strict;
use warnings;

=head1 NAME

SIFTS is a Perl Module for parsing the PDB to UniProt residue 
mappings provided by project SIFTS at the EBI.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module provides parsers to the different SIFTS mappings. 
Several scripts also come along this module for simple command line 
tasks. 

=head2 Scripts

=over 3

=item * B<domid_to_pdbchains>

Reads a list of CATH domain IDs from an input file and returns the 
list of PDB chains that come from the same chain as each of these 
domain IDs. The script is typically called as follow. Use option -h 
for more details on options.

  prompt# domid_to_pdbchains -i domids.dat -o domid_pdbchains.dat 

=back

=head2 Parsers

All parser classes are under SIFTS::IO.

=over 3

=item * B<SIFTS::IO::Text::PdbUniprot>

Parser for the text file mapping PDB chain IDs to Uniprot accession 
codes 'pdb_chains_uniprot.lst'. 

=back

=head2 Entity objects

The following modules are used when processing the mapping data 
files to store the information in a natural hierarchical 
object-oriented framework.

=over 3

=item * B<SIFTS::Dataset>

Stores a SIFTS dataset. A dataset corresponds to a set of at least
one SIFTS::Protein object. 

=item * B<SIFTS::Protein> 

Stores a protein. A protein corresponds to a Uniprot entry. A 
SIFTS::Protein objects can contain several SIFTS::Chain objects. 

=item * B<SIFTS::Chain>

Stores a protein chain. A protein chain corresponds to a PDB chain. 
A SIFTS::Chain object can contain several SIFTS::Segment objects.

=item * B<SIFTS::Segment>

Stores a protein chain segment. A protein chain segment corresponds 
to a continuous stretch of residues that can be mapped between the 
PDB chain and the Uniprot entry. A SIFTS::Segment object can contain
several SIFTS::Residue objects.

=item * B<SIFTS::Residue>

Stores a protein residue.   

=back

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS
