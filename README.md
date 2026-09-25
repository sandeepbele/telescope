# Telescope

> **Archived project.** Telescope is an early photo-cataloging prototype from 2017. It is no longer maintained, and the end-to-end workflow was never completed.

**A local photo catalog built from files and EXIF metadata.**

Telescope started from a simple problem: photos accumulate across folders, disks, and devices, while much of the information needed to organize them is already embedded in the files themselves.

The idea was to scan photo collections, extract camera and timestamp information from EXIF metadata, and build a searchable catalog that could eventually support organization, deduplication, and backup workflows.

## How it was intended to work

The basic pipeline was:

1. recursively scan one or more directories for image files
2. read metadata from each image using ExifTool
3. normalize useful fields such as capture time and camera information
4. store the resulting catalog in SQLite
5. use that catalog to organize or move the original files

The repository contains pieces of that workflow, but not a completed application.

## Repository structure

- `FSWalker.pm` — recursively discovers files and filters them by extension
- `ExifReader.pm` — extracts selected EXIF metadata using ExifTool
- `DBUtil.pm` — experiments with storing photo metadata in SQLite
- `App.pl` — sketches the batch workflow for scanning, extracting metadata, moving files, and recording progress
- `run.pl` — exploratory entry point used while developing the prototype
- `config/app.cfg.example` — example configuration without machine-specific paths

Some steps in `App.pl` remain placeholders.

## Project status

Telescope is preserved as an archive of the original experiment rather than as a maintained photo-management tool.

The sample photos and local database used during development are not included, and the complete scan-to-catalog workflow has not been revalidated on a modern environment.
