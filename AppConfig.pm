package AppConfig;

use strict;
use warnings;
use v5.18;
use Carp;
use File::Spec;
use File::Path;

our $APP_HOME;
our $APP_CFG_FILE = "app.cfg";
our $APP_CFG_DIR = "config";
my $APP_CFG_PATH = "";

sub _init_ {

  my ($home) = @_;
  if (!$home){
    $home = `pwd`;
    chomp $home;
  }
  croak "Can't access App Home:$home" unless -e -d -r -w $home;
  say "\n App Home is:".$home;

  $APP_HOME = $home;
  $APP_CFG_PATH = File::Spec->catfile($APP_HOME,$APP_CFG_DIR,$APP_CFG_FILE);
  File::Path->mkpath($APP_CFG_PATH) unless -e $APP_CFG_PATH;

  croak "Can't read or write App Config File:$APP_CFG_PATH" unless -r -w $APP_CFG_PATH;

  return $home;
}

sub read_config {

    my $config_file = shift;
    $config_file = $APP_CFG_PATH if !$config_file;

    say "Reading config file:".$config_file;
    #package AppConfig;
    do ( $config_file );
}

_init_();
read_config();

1;
