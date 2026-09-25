package ExifReader;

use strict;
use warnings;
use v5.18;
use Carp qw(cluck);
use Image::ExifTool;

our @DEFAULT_EXIF_TAGS = (

	"Make",
	"Model",
	"Categories",
	"CameraType",
	"FileSource",
	"DateTimeOriginal",
	"TimeZone",
	"FileSize",
	"ImageWidth",
	"ImageHeight",
	"ApertureValue",
	"ExposureProgram",
	"ShutterSpeedValue",
	"ShutterSpeed",
	"Orientation",
	"FileCreateDate",
	"WhiteBalance",
	"FNumber",
	"ModifyDate",
	"SelfTimer",
	"FacesDetected",
	"FileCreateDate",
	"Quality",
	"LensID",
  "PreviewImage",
	"ThumbnailImage"
);

sub read {
  my ($image_file,$tags) = @_;

  cluck "File path is required." if !$image_file;

  if (!($tags && @$tags)){
    $tags = \@DEFAULT_EXIF_TAGS;
  }

  return Image::ExifTool::ImageInfo($image_file,@$tags);

}

1;
