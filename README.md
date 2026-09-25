# Telescope

> **Archived project.** Telescope is an early photo-cataloging prototype from 2017. It is no longer maintained and does not have a finished end-to-end workflow.

I started Telescope to make sense of photos scattered across folders and devices. The idea was to walk the files on disk, read camera and date information from their EXIF metadata, and build a catalog that could later help organize and back up the originals.

The repository contains the beginnings of that workflow:

- `FSWalker.pm` finds files recursively and can filter them by extension.
- `ExifReader.pm` reads selected image metadata with ExifTool.
- `DBUtil.pm` explores storing a catalog in SQLite.
- `App.pl` sketches a batch that scans, extracts metadata, moves files, and records progress. Several of those steps are placeholders.
- `run.pl` is an exploratory entry point, not a finished application.

The original sample photos and local database are omitted. `config/app.cfg.example` shows the shape of the old local configuration without paths from my machine. The source folder had no Git repository, so this public repository begins with a new commit rather than a reconstructed history.
