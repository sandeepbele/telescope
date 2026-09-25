package DBUtil;

use strict;
use warnings;
use v5.18;
use Carp;
use AppConfig;
use Data::Dumper;
use DBI;

my %SQL_TYPES = (T => 'SQL_VARCHAR', B => 'SQL_BLOB');
my %table_meta_cache = ();


sub connect {

  my $db_path = shift;
  #$db_path = $AppConfig::env->{db} if !$db_path;
  say "Using DB file: $db_path";
  return DBI->connect("dbi:SQLite:dbname=$db_path","","") or croak "Can't connect to db!";
}

sub connect_to_master_db {
  #print Dumper %AppConfig::env->{master_db};
  my $master_db_file = %AppConfig::env->{'master_db'};
  say "using:".$master_db_file;
  croak "Master DB path is not configured." if (!$master_db_file);
  return &connect($master_db_file);

}

sub insert_into_master {
  my $dbh = shift;
  my $table_name = shift;
  my $row = shift;

  # consider db table is created
  # iterate over columns, read their value type, create hash: col=>type
  # for input hash - lookup in above hash, extract type and bind: name, type & value

  if (!exists $table_meta_cache{$table_name}){
      my $tbh = $dbh->table_info(undef,undef,$table_name);

      while ( my($qual,$owner,$name,$type) = $tbh->fetchrow_array() ){
          $table_meta_cache{$table_name}{$name} = $type;
      }
      say Dumper \%table_meta_cache;
  }

  #my $stmt = 'INSERT INTO img_master VALUES(?)';
  #my $sth = $dbh->prepare($stmt);
  #$sth->bind_param(':'.$db_col,$row[$db_col]);

}

sub close {
  my $dbh = shift;
  $dbh->close();
}

1;
