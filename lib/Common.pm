package Common;

use strict;
use warnings;

use Image::OCR::Tesseract 'get_ocr';
use Image::Info qw(image_info);

use Conf;
use Log::Log4perl;

#turn following on if wish to get tesseract debug on/off
# $Image::OCR::Tesseract::DEBUG = 1;

####################################################################
####################################################################
# sub    :- new
# param  :- invocant
# desc   :- Constructor
# return :- blessed object of this class
####################################################################
#constructor
sub new {
    my $self = shift;

    my $conf = Conf->new();

    Log::Log4perl::init( $conf->{report_logger} );

    my $logger = Log::Log4perl->get_logger( $conf->{report_logger_name} );

    return bless(
        {
            log => $logger
        },
        $self
    );
}
####################################################################
####################################################################
# sub    :- image_to_text
# param  :- invocant, "Full image path" (with extension) {scalar}
# desc   :- this is generic method to call tessseract and get extracted text
#           will print error in case of error occured
# return :- raw extracted text from image
####################################################################
sub image_to_text {
    my ( $self, $image_path ) = @_;

    my $text;
    eval { $text = get_ocr( $image_path ); };
    if ( $@ ) {
        print "ERROR occured while converting image to text $@";
        return;
    } else {
        return $text;
    }
}
####################################################################
####################################################################
# sub    :- get_image_metadata
# param  :- invocant, "Full image path" (with extension) {scalar}
# desc   :- this is generic method will return the image metadata
# return :- hashref of image meta data
#{
# path' => '/tmp/image/4237236353.png',
# info' => {
#            'SampleFormat' => 'U8',
#            'Compression' => 'Deflate',
#            'Chunk-sRGB' => '',
#            'width' => 1350,
#            'file_ext' => 'png',
#            'height' => 608,
#            'file_media_type' => 'image/png',
#            'PNG_Filter' => 'Adaptive',
#            'PNG_Chunks' => [
#                              'IHDR',
#                              'sRGB',
#                              'gAMA',
#                              'pHYs',
#                              'IDAT 6',
#                              'IEND'
#                            ],
#            'color_type' => 'RGBA',
#            'resolution' => '3779 dpm',
#            'Gamma' => '0.45455'
# },
####################################################################
sub get_image_metadata {
    my ( $self, $image_path ) = @_;
    my $meta;
    if ( $self->validate_image_path( $image_path ) ) {
        $meta->{path} = $image_path;
    }

    $meta->{info} = image_info( $image_path );

    if ( my $error = $self->{info}->{error} ) {
        die "Can't parse image info: $error\n";
    }

    return $meta;

}
####################################################################
####################################################################
# sub    :- validate_image_path
# param  :- invocant, "Full image path" (with extension) {scalar}
# desc   :- this is generic method to check if valid image path
#          and file is redable
# return :- true or false in case of invalid
####################################################################
sub validate_image_path {
    my ( $self, $image_path ) = @_;

    unless ( -r -e $image_path ) {
        print "Image Path invalid $image_path";
        return 0;
    }

    return 1;
}
####################################################################
####################################################################
# sub    :- validate_image_path
# param  :- invocant, "Full directory path" {scalar}
# desc   :- this is generic method to get all files in directoty
#          and file is redable
# return :- array of files fullpath
####################################################################
sub get_files_to_process {
    my ( $self, $dir ) = @_;
    return unless ( $dir );

    opendir( DIR, $dir ) or die $!;

    my @file_name;

    while ( my $file = readdir( DIR ) ) {
        my $loc = "$dir/$file";
        next unless ( -f $loc );
        push( @file_name, $loc );
    }

    return @file_name;
}
####################################################################
####################################################################
# sub    :- get_logger
# param  :- invocant
# desc   :- method to retrive logger
# return :- logger object
####################################################################

sub get_logger {
    my $self = shift;
    my $conf = Conf->new();
    Log::Log4perl::init( $conf->{report_logger} );
    return Log::Log4perl->get_logger( $conf->{report_logger_name} );
}
####################################################################
####################################################################
# sub    :- validate_result
# param  :- invocant, result (scalar)
# desc   :- method will validate the obtained result and log it
# return :- true or false
####################################################################
sub validate_result {
    my ( $self, $result ) = @_;

    $self->{log}->info( "validating result '$result'" );
    my $match;
    my $valid = 0;

    #contain word alphabet
    if ( $result =~ /w+/ ) {
        $match = 1;
        $valid = 0;
    }

    #between 1 - 100
    if ( $result =~ /^[1-9][0-9]?$|^100$/ ) {
        $match = 2;
        $valid = 1;
    }

    #between 1 - 100
    if ( $result <= 100 && $result >= 0 ) {
        $match = 3;
        $valid = 1;
    }

    $self->{log}->info( "Matched condition '$match'" );
    $self->{log}->info( "valid result '$result'" ) if ( $valid );

    return $valid;
}

####################################################################
####################################################################
####################################################################
####################################################################
####################################################################
1;
