package SIFTS::IO::Text::PdbUniprot;

use 5.006;
use strict;
use warnings;

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
