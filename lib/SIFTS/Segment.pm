package SIFTS::Segment;

use 5.006;
use strict;
use warnings;

use Carp;

=head1 NAME

SIFTS::Segment - Object representation of a protein chain segment in 
SIFTS.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Represents a Protein Chain Segment in the context of the SIFTS 
mapping.

    use SIFTS::Segment;

    ## Create a new Segment object.
    my $sifts_segment = SIFTS::Segment->new();
    
    ## Assign Segment ID.
    $sifts_segment->id( '1n3lA_1_115' );
    
    ## Set/Get Start Residue.
    $sifts_segment->start_residue( $sifts_residue );
    
    ## Set/Get Stop Residue.
    $sifts_segment->stop_residue( $sifts_residue );
    
=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_segment = SIFTS::Segment->new();
    
  SIFTS::Segment::new creates a new empty SIFTS Protein Chain 
  Segment object.

=cut
sub new {
    my $class = shift;

    my $self           = {};
    $self->{ID}        = undef;
    $self->{START_RES} = undef;
    $self->{STOP_RES}  = undef;

    bless( $self, $class );

    return $self;
}

=head2 id

    $sifts_segment->id( '1n3lA_1_115' );
    
  SIFTS::Segment::id gets a Segment ID as argument for assignment.
  The segment ID should always consist of a PDB ID, a Chain ID, 
  a '_' character, a start position, a '_' character and a stop
  position. Always returns the Segment ID or undef. 

=cut
sub id {
    my $self = shift;
    my $val  = shift;
    
    if ( defined $val ) {

        ## Accepted format is a string of 5 alphanumeric characters,
        ## followed by '_', followed by alphanumeric characters, 
        ## followed by '_', followed by alphanumeric characters.
        if ( $val =~ /^\w{5}_\w+_\w+$/ ) {
            $self->{ID} = $val;
        }
        else {
            carp "Warning: id not assigned due to wrong format ",
                 "($val).";
        }
    }
    
    return $self->{ID};
}

=head2 start_residue

    ## Set.
    $sifts_segment->start_residue( $sifts_residue );
    
    ## Get.
    my $start_residue = $sifts_segment->start_residue();
    
  SIFTS::Segment::start_residue gets a L<SIFTS::Residue> compliant
  object as argument for assignment. Always returns a 
  L<SIFTS::Residue> compliant object or undef.

=cut
sub start_residue {
    my $self      = shift;
    my $start_res = shift;
    
    if ( defined $start_res ) {
    
        if ( $start_res->isa( 'SIFTS::Residue') != 1 ) {
            confess "Error: SIFTS::Segment->start_residue only ",
                    "takes SIFTS::Residue compliant objects for ",
                    "assignment.";
        }
    
        $self->{START_RES} = $start_res;
    }
    
    return $self->{START_RES};
}

=head2 stop_residue

    ## Set.
    $sifts_segment->stop_residue( $sifts_residue );
    
    ## Get.
    my $stop_residue = $sifts_segment->stop_residue();
    
  SIFTS::Segment::stop_residue gets a L<SIFTS::Residue> compliant
  object as argument for assignment. Always returns a 
  L<SIFTS::Residue> compliant object or undef.

=cut
sub stop_residue {
    my $self     = shift;
    my $stop_res = shift;

    if ( defined $stop_res ) {

        if ( $stop_res->isa( 'SIFTS::Residue') != 1 ) {
            confess "Error: SIFTS::Segment->stop_residue only ",
                    "takes SIFTS::Residue compliant objects for ",
                    "assignment.";
        }

        $self->{STOP_RES} = $stop_res;
    }

    return $self->{STOP_RES};
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-segment at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-Segment>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::Segment


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-Segment>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-Segment>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-Segment>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-Segment/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::Segment
