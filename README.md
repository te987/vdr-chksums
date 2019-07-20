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

    -r  repository path
         default: '/srv/dmirror'
         A directory path to a valid debian repository.
         vdr_config: set repo_path /srv/mirror

    -w  number of worker processes
         default: 1    [1..128]
         Too many workers can slow program down.
         Value depends on harware like cpu cores, drives.
         Recommend: SSDrive=1-4, spinning HDrive=1
         vdr_config: set worker_cnt 4

    -c  checksum mode
         default: size    [size md5 sha256]
         Selects a checksum mode based on speed or need.
         size - quick file size checksums
         md5, sha256 - digest hash checksums
         vdr_config: set checksum_mode sha256

    -m  toggles db mode
         default: disabled
         Enables db cache checksum mode
         Uses toggle mode so config file setting can be over-ridden
         Current checksum mode selects db checksum type.
         Current arch mode selects db arch type(s).
         Uses -b option.
         vdr_config: set db_mode 1

    -b  db file,  path/basename or path/:
         default: '~/.local/share/vdr_checksum/vdr_db'
         An extension [_arch_mode][.checksum_mode].bz2 is auto-added.
         Needs basename unless you want [_arch_mode] as basename.
         This bzip2 file caches good checksums of repository files
         so only new files are checksumed.
         Used by -m option.
         vdr_config: set db_file ~/opt/vdr_checksums/mirror/bam

    -e  erase db file based on current arch and checksum type.
         It will erase file and exit.
         Uses -m option to activate. (WARN: No Prompt)
         vdr_config: N.A.

    -f  configuration file
         default: '~/.local/share/vdr_config'
         Needs cfg file format using %config (keys, values).
         'set' must be 1st word delimited by white space.
         format: set  key  value
         vdr_config: N.A.

    -p  package uncompress mode
         default: xz    [none gz xz]
         Selects [Packages Packages.gz Packages.xz]
         for lookup checksums.
         vdr_config: set pkage_cmprs_mode gz

    -a  architecture mode
         For checksums of repositories by arch types.
         default: multi   [multi all amd64, etc]
         multi - a dummy to catch every arch type as in pool/*/*_*.deb
         all   - as in pool/*/*_all.deb, (docs, non-cpu-specific)
         amd64 - as in pool/*/*_amd64.deb (binary-code, cpu-specific)
         Unless using multi you must include arch all either by itself
         or with another arch type to do a full check.
         Arch mode can be a comma delimited, no spaces, list.
         Arch mode is not validated, so get it right.
         vdr_config: set arch_mode all,amd64

    -V  show software version
         vdr_config: N.A.

    -o  checksum error shell script path/filename
         default: '~/remove-vdr-chksum-errors.sh'
         Path and filename are not validated.
         vdr_config: set err_file ~/my_chksum_errors.sh

    -s  toggles checksum error shell script mode
         default: disabled
         The shell script has no execute permissions.
         The shell script removes repository files with bad checksums.
         The mirroring software can be rerun to load correct files.
         The shell script contains only files with checksum errors and
         not package key errors.
         vdr_config: set err_mode 1

# EXAMPLES

## CONFIGURATION

    #  vdr_config example
    set  repo_path  /svr/mirror
    # set  db_mode  1
    set  db_file  ~/.local/share/vdr_checksums/mirror/db
    set  worker_cnt  4
    # set err_mode 1

## OPTIONS

    vdr-chksums -f ~/.local/share/buster_vdr_config -m -c sha256 -s

# AUTHOR

Terry Embry, KJ4EED <mrtembry@gmail.com>
