package Conf;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self;

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
   # $self->{database_host} = 'localhost';

    # The database name
    $self->{database_name} = '';

    # The database user
    $self->{database_user} = '';

    # The password of database user.
    $self->{database_pw} = '';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $self->{database_dsn} = "DBI:mysql:database=$self->{database_name}";

    $self->{database_dsn} .= ";host=$self->{database_host};" if (defined $self->{database_host});

    # ---------------------------------------------------- #
    #
    # Log4Perl config file location
    # ---------------------------------------------------- #

    $self->{report_logger}         = '/project/config/log4perl.conf';
    $self->{report_logger_name}    = 'ocr_log';

    #################################################
    #Custom files upload dir
    ################################################
    #path where file should be uploaded
    $self->{cust_upload_dir} = '/custom_upload';

    #path where finished files should be moved
    $self->{cust_finished_dir} = '/custom_upload/finished';

    #threshold after which files to be deleted (old file)
    $self->{cust_reports_cleanup_threshold} = "25";

    return bless($self, $class);
}

1;