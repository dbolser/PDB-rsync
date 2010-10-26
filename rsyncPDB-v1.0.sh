#!/bin/sh

############################################################################
#
# Script for mirroring PDB FTP archive using rsync
#
############################################################################

# This script is being provided to PDB users as a template for using rsync 
# to mirror the FTP archive from an anonymous rsync server. You may want 
# to review rsync documentation for options that better suit your needs.
#
# Author: Thomas Solomon
# Date:   November 1, 2002

# Hacked by Dan (see below).

# You SHOULD CHANGE the next lines to suit your local setup

RSYNC=`which rsync`				# location of local rsync
PROJECTDIR=/project/StruPPi/BiO			# convenience variable
MIRRORDIR=$PROJECTDIR/DBd/PDB-REMEDIATED	# your top level mirror directory
LOGFILE=$MIRRORDIR/rsync.log			# file for storing logs (broken!)

# You SHOULD NOT CHANGE the next two lines

SERVER=rsync.wwpdb.org			# remote server name (don't add ::stuff)
PORT=33444				# rsync port the remote server is using

#
# Rsync the entire FTP archive /pub/pdb (Aproximately 10 GB)
#

#${RSYNC} -rlpt -v -z --delete --port=$PORT $SERVER::ftp/ $MIRRORDIR > $LOGFILE 2>/dev/null



# The above command was changed by Dan;
#
# 1) Added 'extra command' support ($*), which is useful for '-n'.
#
# 2) Added a "don't delete these files file" (see --exclude-from).
#
# 3) Allow specific sub-directory retreival (with $GRAB).
#
# 4) Removed the (somehow broken) implicit logging (should now log
#    from the external call).
#
# 5) Fixed command layout (to taste).
#



## Use the following to GRAB a specific sub directory if necessary
## (don't forget to *exclude* the trailing slash!)...

GRAB="."
#GRAB=data/structures/divided/pdb
#GRAB=data/structures/divided/pdb/da

$RSYNC $*					\
    --delete					\
    --archive					\
    --verbose					\
    --compress					\
    --exclude-from=$MIRRORDIR/exclude.list      \
    --port=$PORT				\
    $SERVER::ftp/$GRAB/				\
    $MIRRORDIR/$GRAB

# See the 'WARNING-READ-THIS' file about the above '--exclude-from'
# option.



## REST OF (UNALTERED) FILE FOLLOWS...



#
# Rsync only the data directory /pub/pdb/data (Aproximately 9.6 GB)
#

#${RSYNC} -rlpt -v -z --delete --port=$PORT $SERVER::ftp_data/ $MIRRORDIR/data > $LOGFILE 2>/dev/null


#
#  Rsync only the derived data directory /pub/pdb/derived_data (Aproximately 40 MB)
#

#${RSYNC} -rlpt -v -z --delete --port=$PORT $SERVER::ftp_derived/ $MIRRORDIR/derived_data > $LOGFILE 2>/dev/null


#
#  Rsync only the doc directory /pub/pdb/doc (Aproximately 200 MB)
#

#${RSYNC} -rlpt -v -z --delete --port=$PORT $SERVER::ftp_doc/ $MIRRORDIR/doc > $LOGFILE 2>/dev/null


#
#  Rsync only the software directory /pub/pdb/software (Aproximately 20 MB)
#

#${RSYNC} -rlpt -v -z --delete --port=$PORT $SERVER::ftp_software/ $MIRRORDIR/software > $LOGFILE 2>/dev/null


