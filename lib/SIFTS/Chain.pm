package SIFTS::Chain;

use 5.006;
use strict;
use warnings;

=head1 NAME

SIFTS::Chain - Object representation of a protein chain in SIFTS.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Represents a protein chain in the context of the SIFTS mapping.

    use SIFTS::Chain;

    my $sifts_chain = SIFTS::Chain->new();
    
    ## Set Chain ID.
    $sifts_chain->pdbchainid( '1n3lA' );
    
    ## Assign a new SIFTS::Segment to the Chain.
    my $sifts_segment = SIFTS::Segment->new();
    $sifts_chain->add_segment( $sifts_segment );
    
    ## Set/Get a list of SIFTS::Segment objects that constitute the 
    ## Chain.
    my $sifts_segment1 = SIFTS::Segment->new();
    my $sifts_segment2 = SIFTS::Segment->new();
    my @sifts_segments = ( $sifts_segment1, $sifts_segment2 );
    $sifts_chain->segments( \@sifts_segments );
    
    ## Retrieve a SIFTS::Segment with a particular Segment ID from 
    ## the SIFTS::Chain object.
    my $sifts_segment = $sifts_chain->get_segment( 
        id => '1n3lA_1_173' 
    );

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_chain = SIFTS::Chain->new();
    
  SIFTS::Chain::new creates a new empty SIFTS Protein Chain object.

=cut
sub new {
}

=head2 pdbchainid

    $sifts_chain->pdbchainid( '1n3lA' );
    
  SIFTS::Chain::pdbchainid gets a PDB chain ID as argument for 
  assignment. The PDB chain ID should always consist of a PDB ID 
  followed by a one-letter chain ID. Always returns a PDB chain ID 
  or undef. 

=cut
sub pdbchainid {

}

=head2 add_segment

    my $sifts_segment = SIFTS::Segment->new();
    $sifts_chain->add_segment( $sifts_segment );
    
  SIFTS::Chain::add_segment gets a L<SIFTS::Segment> compliant 
  object as argument for assignment. The L<SIFTS::Segment> object 
  will be added to the current list of Segments in the SIFTS Protein 
  Chain. Returns 1 upon success, 0 upon failure. 

=cut
sub add_segment {
}

=head2 segments

    ## Assign.
    my $sifts_segment1 = SIFTS::Segment->new();
    my $sifts_segment2 = SIFTS::Segment->new();
    my @sifts_segments = ( $sifts_segment1, $sifts_segment2 );
    $sifts_chain->segments( \@sifts_segments );
    
    ## Retrieve.
    my $sifts_segments_aref = $sifts_chain->segments();
    
  SIFTS::Chain::segments gets a reference to an array of 
  L<SIFTS::Segment> compliant objects as argument for assignment. 
  Always returns a reference to an array of L<SIFTS::Segment> 
  objects contained in the Protein Chain. The returned array may be 
  empty.

=cut
sub segments {
}

=head2 get_segment

    my $sifts_segment = $sifts_chain->get_segment( 
        id => '1n3lA_1_115',
    );
    
  SIFTS::Chain::get_segment gets a segment ID as argument and 
  searches the Protein Chain object for a L<SIFTS::Segment> object 
  with that ID. Returns the L<SIFTS::Segment> object if it finds it, 
  undef otherwise.

=cut
sub get_segment {
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-chain at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-Chain>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::Chain


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-Chain>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-Chain>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-Chain>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-Chain/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::Chain
