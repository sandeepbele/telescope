use strict;
use warnings;
use v5.18;

use Data::Dumper;

my $APP_HOME =  `pwd`;
chomp $APP_HOME;
say "APP HOME is:".$APP_HOME;
# read config
#my %cfg = ();
&read_config($APP_HOME);
my $config = \%CFG::cfg;
#print Dumper $config;

&load_hashes();

my $batch_id = rand();
my ($success,$error) = &run_batch($batch_id, $config);
&update_batch_status_to_db($batch_id,$success,$error);
&send_mail($batch_id,$success,$error);

sub read_config {

  my $config_file = shift . "/config/app.cfg";
  say "Reading config file:".$config_file;
  package CFG;
  do ( $config_file );

}

sub load_hashes {
  say "loaded all file hash values";
}

sub run_batch {

  my ($batch_id, $config) = @_;

  # scan files with \@ext at \@scope
  say "\nScanning for batch ".$batch_id."started.";
  my (@files) = &scan_files($config->{scope},$config->{ext});
  say "\nScanning finished. ".scalar @files." files found.";

  my ($success,$error) = (0,0);

  foreach (@files) {
    my $exif_data = &extract_exif($_);
    my $s = undef;
    if (!$exif_data) {
      $error++;
      next;
    }
    $s = move($_,$config->{cloud});

    if (!$s){
      $error++;
      next;
    }
    my $u = update_db($exif_data);
    if (!$u){
      $error++;
      next;
    }
    $success++;
    }
    return ($success,$error);
}


sub scan_files {

  return ('file1','file2');

}

sub extract_exif {
  my $file = shift;
  say "\n Exif data extracted for:". $file;
  return { exif => 'dada'};
}

sub move {
  my ($file, $cloud) = @_;
  say "\n Moved ".$file." to ".$cloud;
}

sub update_db {
  my $exif_rec = shift;
  say "\n Updated db for $exif_rec";
}

sub update_batch_status_to_db {
  my ($batch_id,$success,$error) = @_;
  say "\n Updated status in db for ".$batch_id."- success:".$success.", error:".$error;
}

sub send_mail {
  my ($batch_id,$success,$error) = @_;
  say "\n sent mail for ".$batch_id."- success:".$success.", error:".$error;
}


# for each file
  # extract exif
    # push exif to db
    # copy file to cloud or error
    # mark file as completed/failed in db


# table_1: batch_id, f_hashcode, f_is_moved, f_moved_when, err
# table_2: batch_id, who, started, ended, scanned, success, error
# table_3: f_hashcode, f_path, f_thumb
# table_4: f_hashcode, exif & other data .....

#send email with status
#sleep
