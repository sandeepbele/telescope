package FSWalker;

use strict;
use warnings;
use v5.18;
use Carp;
use File::Find;

# { roots => ['/users/x'], matches=> ext => ['jpg','jpeg'] }
sub list_files {

    my ($criteria) = @_;

    my $scan_roots = $criteria->{roots};
    if (!@$scan_roots){
      carp "Root folders for scanning not provided,returning with empty hands!";
      return ();
    }

    my $ext = $criteria->{matches}{ext};
    my $file_ext_pattern = undef;
    $file_ext_pattern = join"|", @$ext if ($ext && @$ext);

    my @image_files;

    #find all images
    find (
      {
        #preprocess=>\&preprocess,
        wanted=>sub {
            push @image_files,$File::Find::name if (!$file_ext_pattern or m!\.($file_ext_pattern)$!i);
          }
      },
        @$scan_roots
    );

    return @image_files;
}

1;
