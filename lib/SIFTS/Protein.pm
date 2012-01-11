package SIFTS::Protein;

use 5.006;
use strict;
use warnings;

use Carp;

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
    my $sifts_chain = $sifts_protein->get_chain( 
        pdbchainid => '1n3lA' 
    );

=head1 SUBROUTINES/METHODS

=head2 new

    my $sifts_protein = SIFTS::Protein->new();
    
  SIFTS::Protein::new creates a new empty SIFTS Protein object.

=cut
sub new {
    my $class = shift;

    my $self = {};
    $self->{UNIACC} = undef;
    $self->{CHAINS} = {};

    bless( $self, $class );

    return $self;
}

=head2 uniacc

    $sifts_protein->uniacc( 'P53093' );
    
  SIFTS::Protein::id gets a Protein Uniprot Accession code as 
  argument for assignment. The Protein Uniprot Accession code should
  always consist of a string with 6 alphanumeric characters. Always 
  returns the uniprot accession code or undef.  

=cut
sub uniacc {
    my $self = shift;
    my $val  = shift;
    
    if ( defined $val ) {

        ## Accepted format is a string of 6 alphanumeric characters.
        if ( $val =~ /^\w{6}$/ ) {
            $self->{UNIACC} = $val;
        }
        else {
            carp "Warning: id not assigned due to wrong format ",
                 "($val).";
        }
    }
    
    return $self->{UNIACC};
}

=head2 add_chain

    my $sifts_chain = SIFTS::Chain->new();
    $sifts_protein->add_chain( $sifts_chain );
    
  SIFTS::Protein::add_chain gets a L<SIFTS::Chain> compliant object 
  as argument for assignment. The L<SIFTS::Chain> object will be 
  added to the current list of Chains in the SIFTS Protein. The 
  chain should have a defined pdb chain ID. Returns 1 upon success. 

=cut
sub add_chain {
    my $self        = shift;
    my $sifts_chain = shift;
    
    if ( ! defined $sifts_chain ) {
        confess "Error: SIFTS::Protein->add_chain expects an ",
                "argument for assignment.";
    }

    if ( $sifts_chain->isa( 'SIFTS::Chain' ) != 1 ) {
        confess "Error: SIFTS::Protein->add_chain only takes ",
                "SIFTS::Chain compliant objects for assignment.";
    }
    
    if ( ! defined $sifts_chain->pdbchainid ) {
        confess "Error: SIFTS::Protein->add_chain only takes a ",
                "SIFTS::Chain with defined PDB chain ID for ",
                "assignment.";
    }

    $self->{CHAINS}{ $sifts_chain->pdbchainid } = $sifts_chain;

    return 1;
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
  All chains in the array should have a defined PDB chain ID.
  Always returns a reference to an array of L<SIFTS::Chain> objects 
  contained in the Protein. The returned array may be empty.

=cut
sub chains {
    my $self              = shift;
    my $sifts_chains_aref = shift;
    
    if ( defined $sifts_chains_aref ) {
        
        for my $sifts_chain ( @{ $sifts_chains_aref } ) {
            
            ## Check that chain object is SIFTS::Chain compliant.
            if ( $sifts_chain->isa( 'SIFTS::Chain' ) != 1 ) {
                confess "Error: attempting to add a non ", 
                        "SIFTS::Chain compliant object into ",
                        "SIFTS::Protein->chains!";
            }
            
            ## Check that chain object has a defined pdbchainid 
            ## attribute.
            if ( defined $sifts_chain->pdbchainid() ) {
                $self->{CHAINS}{ $sifts_chain->pdbchainid() } 
                    = $sifts_chain;
            }
            else {
                confess "Error: attempting to add a SIFTS::Chain ",
                        "object with undefined pdbchainid ",
                        "attribute into SIFTS::Protein->chains!";
            }
        }
    }
    
    my @chains = values %{ $self->{CHAINS} };
    
    return \@chains;
}

=head2 get_chain

    my $sifts_chain = $sifts_protein->get_chain( 
        pdbchainid => '1n3lA',
    );
    
  SIFTS::Protein::get_chain gets a PDB chain ID as argument and
  searches the Protein object for a L<SIFTS::Chain> object with that
  ID. Returns the L<SIFTS::Chain> object if it finds it, undef 
  otherwise.

=cut
sub get_chain {
    my $self   = shift;
    my %arg    = @_;

    ## Check mandatory argument pdbchainid is defined.
    confess "Missing mandatory argument pdbchainid.\n"
        unless ( exists $arg{'pdbchainid'} );

    my $chain = ( exists $self->{CHAINS}{$arg{'pdbchainid'}} ) 
              ? $self->{CHAINS}{$arg{'pdbchainid'}} : undef;
    
    return $chain;
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
