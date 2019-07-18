# NAME

vdr-chksums - A Perl 5 script to verify debian repository checksums.
Run as a normal usr, not root.  It needs only read access to repository.

# SYNOPSIS

vdr-chksums \[configuration\_file\] \[options\]

# DESCRIPTION

Indepentent verification of debian repository size, md5, and sha256 checksums.
Provides post support for mirror operations.  vdr-chksums is useful when
mirror operations can not be used to get a repository all at once, downloading
errors, and internet outages.  vdr-chksums can db cache of good checksums for
faster rerun speeds on mirror updates.  vdr-chksums can also provide a
bad checksum file to remove or verify errors.

# COMMENTS

    vdr-chksums -h for usage
    Using Packages:
     findutils, find:   error reporting
     coreutils, mkdir:  make db file path
     gzip,      gunzip: uncompress Packages.gz files
     xz-utils,  unxz:   uncompress Packages.xz files
     libpod-markdown-perl, pod2markdown: Makefile
    For this script, not using perl's default implied variables

# FILES

`~/.local/share/vdr_checksum/var_db.[checksum_mode].bz2`
   - bzip2 db cache

`~/.local/share/vdr_config`
   - configuration

# OPTIONS

    Checksum files to verify repository integrity
    -h          Shows usage and configuration for setup testing.

    -r  string, repository path
                 default: '/home/opt/debian/buster/mirror'
                 A directory path to a valid debian repository.

    -w  int,    number of worker processes
                 default: 1    [1..128]
                 Too many workers can slow program down.
                 Value depends on harware like cpu cores, drives.
                 Recommend: SSDrive=2-4, spinning HDrive=1

    -c  string, checksum mode
                 default: size    [size md5 sha256]
                 Selects a checksum mode based on speed or need.
                  size - quick file size checksums
                  md5, sha256 - digest hash checksums

    -m  switch, toggles db mode
                 default: disabled
                 Enables db cache checksum mode
                 Uses toggle mode so config file setting can be over-ridden
                 Current checksum mode selects db checksum type.
                 Current arch mode selects db arch type(s).
                 Uses -b option.

    -b  string, db file,  path/basename or path/
                 default: '~/.local/share/vdr_checksum/buster/vdr_db'
                 An extension [_arch_mode][.checksum_mode].bz2 is auto-added.
                 Needs basename unless you want [_arch_mode] as basename.
                 This bzip2 file caches good checksums of repository files
                 so only new files are checksumed.
                 Used by -m option.

    -e  switch, Erase db file based on current arch and checksum type.
                 It will erase file and exit.
                 Uses -m option to activate. (WARN: No Prompt)

    -f  string, configuration file
                 default: '~/.local/share/vdr_config'
                 Needs cfg file format using %config (keys, values).
                 'set' must be 1st word delimited by white space.
                 format: set  key  value

    -p  string, package uncompress mode
                 default: xz    [none gz xz]
                 Selects [Packages Packages.gz Packages.xz]
                 for lookup checksums.

    -a  string, architecture mode
                 For checksums of repositories by arch types.
                 default: multi   [multi all amd64, etc]
                 multi - a dummy to catch every arch type as in pool/*/*_*.deb
                 all   - as in pool/*/*_all.deb, (docs, non-cpu-specific)
                 amd64 - as in pool/*/*_amd64.deb (binary-code, cpu-specific)
                 Unless using multi you must include arch all either by itself
                 or with another arch type to do a full check.
                 Arch mode can be a comma delimited, no spaces, list.
                 Arch mode is not validated, so get it right.

    -V  switch, show software version

    -o  string, checksum error shell script path/filename
                default: '~/remove-vdr-chksum-errors.sh'
                Path and filename are not validated.

    -s  switch, toggles checksum error shell script mode
                default: disabled
                The shell script has no execute permissions.
                The shell script removes repository files with bad checksums.
                The mirroring software can be rerun to load correct files.
                The shell script contains only files with checksum errors and
                not package key errors.

# EXAMPLES

## CONFIGURATION

    #  vdr_config example
    noset  checksum_mode  size
    # set  checksum_mode  md5
    set  checksum_mode  sha256
    # set  pkage_cmprs_mode  gz
    set  pkage_cmprs_mode  xz
    set  repo_path  /home/opt/debian/buster/mirror
    noset  db_mode  0
    set  db_mode  1
    #  path or path + preamble
    set  db_file  ~/.local/share/vdr_checksums/buster/db
    set  worker_cnt  4
    # set  arch_mode  multi
    set  arch_mode  all,amd64
    set  err_file  ~/.local/share/my_errs_to_rm
    set err_mode 1

## OPTIONS

    vdr-chksums -f ~/.local/share/buster_vdr_config -m -c sha256 -s
    vdr-chksums -a multi : vdr-chksums -a all,amd64
    vdr-chksums -a all : vdr-chksums -a amd64

# AUTHOR

Terry Embry, KJ4EED <mrtembry@gmail.com>
