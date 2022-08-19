package Extract::PNG;
use strict;
use warnings;
use JSON qw(encode_json);
use Common;
use Data::Dumper;

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
    my $self = shift;

    return bless({common => Common->new() }, $self);
}
####################################################################
##################################
#
#
#
#
#
####################################

sub extract_text {
    shift->_extract_text(@_);
}

####################################################################
##################################
#
#
#
#
#
####################################

sub _extract_text {
    my ($self, $meta) = @_;

    my $image_info = $meta->{info};

    my $result     = undef;
    my $height     = $image_info->{height};
    my $width      = $image_info->{width};
    my $resolution = $image_info->{resolution};
    my $color_type = $image_info->{color_type};
    my $gamma      = $image_info->{Gamma};

    $self->{common}->{log}->debug("image metadata  ".encode_json($meta));

    if ($height eq '608' && $width eq '1350' && $resolution eq '3779 dpm' && $color_type eq 'RGBA' && $gamma eq '0.45455'){
        $result = $self->png_type_1($meta);
    }

    return $result;

}

####################################################################
##################################
#
#
#
#
#
####################################
# 'height' => 608,
# 'color_type' => 'RGBA',
# 'width' => 1350,
# 'Gamma' => '0.45455',
# 'file_ext' => 'png',
# 'resolution' => '3779 dpm'

#eg "/project/image/4237133171.jpg";

sub png_type_1 {

    my ($self, $meta) = @_;

    my $result = undef;

    $self->{common}->{log}->debug(__PACKAGE__ ."::png_type_1 selected");

    my $text = $self->{common}->image_to_text($meta->{path});

    $self->{common}->{log}->debug(encode_json({extract_text => $text}));

    #C68
    $text =~ /\b^[A-Z](\d{0,2})\b/mg;

    $result = $1 if($self->{common}->validate_result($1));

    $self->{common}->{log}->info("result : '$result'");

    return $result;
}

1;