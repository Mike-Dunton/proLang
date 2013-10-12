#!/bin/tcsh
setenv DIR .
setenv PATH $PATH:usr/ucb:/usr/etc:/usr/local/bin/X11:/usr/bin/X11:/usr/openwi/bin:/usr/ccs/bin:/usr/sbin:.:/usr/local/bin:/usr/bin
echo "Changing directory to $DIR..."
chdir $DIR
echo "Archiving..."
tar -cvf project1.tar proj1.scm
gzip project1.tar
uuencode project1.tar.gz < project1.tar.gz > project1
elm -s "project1 submission" cop4020p < project1
echo "Cleaning up..."
rm -f $DIR/project1
rm -f $DIR/project1.tar.gz
