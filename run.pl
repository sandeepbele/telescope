use strict;
use v5.18;
#use FSWalker;
#use ExifReader;
use AppConfig;
use DBUtil;
use Data::Dumper;

#say &FSWalker::list_files({ roots => ['./data/photos'], matches => {ext => ['jpg','jpeg']}});

#say Dumper ExifReader::read('./data/photos/example.jpg');
#say Dumper ExifReader::read('./data/photos/example.jpg',['Model']);

#AppConfig::_init_();
#AppConfig::read_config();
print Dumper \%AppConfig::env;

#DBUtil::connect("quck quack");
my $dbh = DBUtil::connect_to_master_db();
DBUtil::insert_into_master($dbh,"img_master");
DBUtil::close($dbh);
