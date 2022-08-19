package Extract;

use strict;
use warnings;
use Data::Dumper;


use Common;
use Extract::PDF;
use Extract::JPG;
use Extract::PNG;


####################################################################
##################################
#
#
#
#
#
####################################
#constructor
sub new {
    my $self   = shift;
    my $common = Common->new();

    return bless( { log => $common->{log} }, $self );
}
####################################################################
##################################
#
#
#

#
####################################
sub parse_by_type {
    my ( $self, $meta ) = @_;

    my $type = $meta->{info}->{file_ext};

    $self->{log}->info("Image path is '$meta->{path}'");

    if ( uc( $type ) eq 'PNG' ) {

        $self->{log}->info( 'PNG extractor selected' );

        my $png = Extract::PNG->new();

        return $png->extract_text( $meta  );

    } elsif ( uc( $type ) eq 'JPG' ) {

        $self->{log}->info( 'JPG extractor selected' );

        my $png = Extract::JPG->new();

        return $png->extract_text( $meta );

    } elsif ( uc( $type ) eq 'PDF' ) {

        $self->{log}->info( 'PDF extractor selected' );

        my $png = Extract::PDF->new();

        return $png->extract_text( $meta  );

    } else {

        $self->{log}->error( "Unknown file type $type" );

    }

}

1;