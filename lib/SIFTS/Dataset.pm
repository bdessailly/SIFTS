package SIFTS::Dataset;

use 5.006;
use strict;
use warnings;

use Carp;

=head1 NAME

SIFTS::Dataset - Object representation of a SIFTS mapping dataset.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Represents a SIFTS mapping dataset. 

    use SIFTS::Dataset;

    my $sifts_dataset = SIFTS::Dataset->new();
    
    ## Assign a new SIFTS::Protein object to the dataset.
    my $sifts_protein = SIFTS::Protein->new();
    $sifts_dataset->add_protein( $sifts_protein );
    
    ## Set a list of SIFTS::Protein objects that constitute the 
    ## dataset.
    my @sifts_proteins = ( $sifts_protein1, $sifts_protein_2 );
    $sifts_dataset->proteins( \@sifts_proteins );
    ## Get a list of SIFTS::Protein objects that constitute the 
    ## dataset.
    my $sifts_proteins_aref = $sifts_dataset->proteins();
    
    ## Retrieve a specific SIFTS::Protein object from the 
    ## SIFTS::Dataset.
    $sifts_dataset->get_protein( uniacc => 'P54399' )

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_dataset = SIFTS::Dataset->new();
    
  SIFTS::Dataset::new creates a new empty SIFTS dataset object.

=cut
sub new {
    my $class = shift;

    my $self = {};
    $self->{PROTEINS} = {};

    bless( $self, $class );

    return $self;
}

=head2 add_protein

    $sifts_dataset->add_protein( $sifts_protein );
    
  SIFTS::Dataset::add_protein gets a L<SIFTS::Protein> compliant 
  object as argument for assignment. The protein should have a 
  defined Uniprot accession. The protein will be added to the 
  current list of Proteins in the SIFTS Dataset. Returns 1 upon
  success.

=cut
sub add_protein {
    my $self          = shift;
    my $sifts_protein = shift;
    
    if ( ! defined $sifts_protein ) {
        confess "Error: SIFTS::Dataset->add_protein expects a ",
                "SIFTS protein object as argument for assignment.";
    }
    
    if ( $sifts_protein->isa( 'SIFTS::Protein' ) != 1 ) {
        confess "Error: SIFTS::Dataset->add_protein expects a ",
                "SIFTS::Protein compliant object for assignment.";
    }
    
    if ( ! defined $sifts_protein->uniacc ) {
        confess "Error: SIFTS::Dataset->add_protein expects a ",
                "SIFTS::Protein object with defined uniacc for ",
                "assignment.";
    }
    
    $self->{PROTEINS}{ $sifts_protein->uniacc } = $sifts_protein;
    
    return 1;
}

=head2 proteins

    my @sifts_proteins = ( $sifts_protein1, $sifts_protein_2 );
    $sifts_dataset->proteins( \@sifts_proteins );
    
  SIFTS::Dataset::proteins gets a reference to an array of 
  L<SIFTS::Protein> compliant ojbects as argument for assignment.
  All proteins in the array reference should have defined uniprot
  accession attributes. Always returns a reference to an array of 
  Protein objects currently contained in the Dataset. The array may 
  be empty.  
  
=cut
sub proteins {
    my $self                = shift;
    my $sifts_proteins_aref = shift;
    
    if ( defined $sifts_proteins_aref ) {
        
        for my $sifts_protein ( @{ $sifts_proteins_aref } ) {
            
            ## Check that protein object is SIFTS::Protein compliant.
            if ( $sifts_protein->isa( 'SIFTS::Protein' ) != 1 ) {
                confess "Error: attempting to add a non ", 
                        "SIFTS::Protein compliant object into ",
                        "SIFTS::Dataset->proteins!";
            }
            
            ## Check that protein object has a defined uniacc 
            ## attribute.
            if ( defined $sifts_protein->uniacc() ) {
                $self->{PROTEINS}{ $sifts_protein->uniacc() } 
                    = $sifts_protein;
            }
            else {
                confess "Error: attempting to add a SIFTS::Protein ",
                        "object with undefined uniacc attribute ",
                        "into SIFTS::Dataset->proteins!";
            }
        }
    }
    
    my @proteins = values %{ $self->{PROTEINS} };
    
    return \@proteins;
}

=head2 get_protein

    my $sifts_protein = $sifts_dataset->get_protein( 
        uniacc => 'P54399', 
    );
    
  SIFTS::Dataset::get_protein gets a Uniprot accession code as 
  mandatory argument and searches the Dataset for a 
  L<SIFTS::Protein> object with that ID. Returns the 
  L<SIFTS::Protein> object if it finds it, undef otherwise.

=cut
sub get_protein {
    my $self   = shift;
    my %arg    = @_;

    ## Check mandatory argument uniacc is defined.
    confess "Missing mandatory argument uniacc.\n"
        unless ( exists $arg{'uniacc'} );

    my $protein = ( exists $self->{PROTEINS}{$arg{'uniacc'}} ) 
             ? $self->{PROTEINS}{$arg{'uniacc'}} : undef;
    
    return $protein;
}

=head1 AUTHOR

Benoit H Dessailly, C<< <benoit at nibio.go.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sifts-dataset at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SIFTS-Dataset>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SIFTS::Dataset


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SIFTS-Dataset>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SIFTS-Dataset>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SIFTS-Dataset>

=item * Search CPAN

L<http://search.cpan.org/dist/SIFTS-Dataset/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Benoit H Dessailly.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SIFTS::Dataset
