#
# Regular cron jobs for the vdr-chksums package
#
0 4	* * *	root	[ -x /usr/bin/vdr-chksums_maintenance ] && /usr/bin/vdr-chksums_maintenance
