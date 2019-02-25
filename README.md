<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rev="made" href="mailto:root@localhost" />
</head>

<body>



<ul id="index">
  <li><a href="#NAME">NAME</a></li>
  <li><a href="#SYNOPSIS">SYNOPSIS</a></li>
  <li><a href="#DESCRIPTION">DESCRIPTION</a></li>
  <li><a href="#COMMENTS">COMMENTS</a></li>
  <li><a href="#FILES">FILES</a></li>
  <li><a href="#OPTIONS">OPTIONS</a></li>
  <li><a href="#EXAMPLES">EXAMPLES</a>
    <ul>
      <li><a href="#CONFIGURATION">CONFIGURATION</a></li>
      <li><a href="#OPTIONS1">OPTIONS</a></li>
    </ul>
  </li>
  <li><a href="#AUTHOR">AUTHOR</a></li>
</ul>

<h1 id="NAME">NAME</h1>

<p>vdr-chksums - A Perl 5 script to verify debian repository checksums. Run as a normal usr, not root. It needs only read access to repository.</p>

<h1 id="SYNOPSIS">SYNOPSIS</h1>

<p>vdr-chksums [configuration_file] [options]</p>

<h1 id="DESCRIPTION">DESCRIPTION</h1>

<p>Indepentent verification of debian repository size, md5, and sha256 checksums. Provides post support for apt-mirror. vdr-chksums is useful when apt-mirror can not be used to get a repository all at once, downloading errors, and internet outages. vdr-chksums can db cache of good checksums for faster rerun speeds on apt-mirror updates.</p>

<h1 id="COMMENTS">COMMENTS</h1>

<pre><code> vdr-chksums -h for usage
 Using_Packages:
  findutils, find:   error reporting
  coreutils, mkdir:  make db file path
  gzip,      gunzip: uncompress Packages.gz files
  xz-utils,  unxz:   uncompress Packages.xz files
 For this script, not using perl&#39;s default implied variables</code></pre>

<h1 id="FILES">FILES</h1>

<p><i>~/.local/share/vdr_checksum/var_db.[checksum_mode].bz2</i> - bzip2 db cache</p>

<p><i>~/.local/share/vdr_config</i> - configuration</p>

<h1 id="OPTIONS">OPTIONS</h1>

<pre><code> Checksum files to verify repository integrity
 -h          Shows usage and configuration for setup testing.

 -r  string, repository path
              default: &#39;/home/opt/debian/stretch/mirror&#39;
              A directory path to a valid debian repository.

 -w  int,    number of worker processes
              default: 1    [1..128]
              Too many workers can slow program down.
              Value depends on harware like cpu cores, drives.
              Recommend: SSDrive=2-4, HDrive=1

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

 -b  string, db file,  path/basename
              default: &#39;~/.local/share/vdr_checksum/vdr_db&#39;
              An extension [_arch_mode][.checksum_mode].bz2 is auto-added.
              Needs basename unless you want [_arch_mode] as basename.
              This bzip2 file caches good checksums of repository files
              so only new files are checksumed.
              Used by -m option.

 -e  switch, Erase db file based on current arch and checksum type.
              It will erase file and exit.
              Uses -m option to activate. (WARN: No Prompt)

 -f  string, configuration file
              default: &#39;~/.local/share/vdr_config&#39;
              Needs cfg file format using %config (keys, values).
              &#39;set&#39; must be 1st word delimited by white space.
              format: set  key  value

 -p  string, package uncompress mode
              default: none    [none gz xz]
              Selects [Packages Packages.gz Packages.xz]
              for lookup checksums.

 -a  string, architecture mode
              For checksums of repositories by arch types.
              default: multi   [multi all amd64, etc...]
              multi - a dummy to catch every arch type as in pool/*/*_*.deb
              all   - as in pool/*/*_all.deb, (docs, non-cpu-specific)
              amd64 - as in pool/*/*_amd64.deb (binary-code, cpu-specific)
              Unless using multi you must include arch all either by itself
              or with another arch type to do a full check.
              Arch mode can be a comma delimited, no spaces, list.
              Arch mode is not validated, so get it right.</code></pre>

<h1 id="EXAMPLES">EXAMPLES</h1>

<h2 id="CONFIGURATION">CONFIGURATION</h2>

<pre><code> #  vdr_config example
 noset  checksum_mode  size
 # set  checksum_mode  md5
 set  checksum_mode  sha256
 set  pkage_cmprs_mode  none
 # set  pkage_cmprs_mode  gz
 # set  pkage_cmprs_mode  xz
 set  repo_path  /home/opt/debian/stretch/mirror
 noset  db_mode  0
 set  db_mode  1
 set  db_file  ~/.local/share/vdr_config_stretch/db
 set  worker_cnt  4
 # set  arch_mode  multi
 set  arch_mode  all,amd64</code></pre>

<h2 id="OPTIONS1">OPTIONS</h2>

<pre><code> vdr-chksums -f ~/vdr_config_Buster -m -c sha256
 vdr-chksums -a multi : vdr-chksums -a all,amd64
 vdr-chksums -a all : vdr-chksums -a amd64</code></pre>

<h1 id="AUTHOR">AUTHOR</h1>

<p>Terry Embry, KJ4EED &lt;mrtembry@gmail.com&gt;</p>


</body>

</html>


