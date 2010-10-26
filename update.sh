#!/bin/sh

BASEDIR=/project/StruPPi/BiO/DBd/PDB-REMEDIATED
LOGFILE=$BASEDIR/rsync.log

echo
date
date > $LOGFILE

echo
echo RSYNCING!

$BASEDIR/rsyncPDB-v1.0.sh >> $LOGFILE



## Look away...

echo 
echo "NEW AND/OR UPDATED stats:"

echo "PDB;              " \
  "all"     `grep -c "^data/structures/all/pdb/.*\.ent.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/pdb/.*\.ent.gz$" $LOGFILE`.

echo "mmCIF;            " \
  "all"     `grep -c "^data/structures/all/mmCIF/.*\.cif.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/mmCIF/.*\.cif.gz$" $LOGFILE`.

echo "XML;              " \
  "all"     `grep -c "^data/structures/all/XML/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/XML/.*\.xml.gz$" $LOGFILE`.

echo "XML-noatom;       " \
  "all"     `grep -c "^data/structures/all/XML-noatom/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/XML-noatom/.*\.xml.gz$" $LOGFILE`.

echo "XML-extatom;      " \
  "all"     `grep -c "^data/structures/all/XML-extatom/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/XML-extatom/.*\.xml.gz$" $LOGFILE`.

echo "Structure factors;" \
  "all"     `grep -c "^data/structures/all/structure_factors/.*\.ent.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/structures/divided/structure_factors/.*\.ent.gz$" $LOGFILE`.

echo "BioUnit;          " \
  "all"     `grep -c "^data/biounit/coordinates/all/.*\.gz$" $LOGFILE`, \
  "divided" `grep -c "^data/biounit/coordinates/divided/.*\.gz$" $LOGFILE`.


echo
echo "DELETED stats:"

echo "PDB;              " \
  "all"     `grep -c "^deleting data/structures/all/pdb/.*\.ent.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/pdb/.*\.ent.gz$" $LOGFILE`.

echo "mmCIF;            " \
  "all"     `grep -c "^deleting data/structures/all/mmCIF/.*\.cif.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/mmCIF/.*\.cif.gz$" $LOGFILE`.

echo "XML;              " \
  "all"     `grep -c "^deleting data/structures/all/XML/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/XML/.*\.xml.gz$" $LOGFILE`.

echo "XML-noatom;       " \
  "all"     `grep -c "^deleting data/structures/all/XML-noatom/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/XML-noatom/.*\.xml.gz$" $LOGFILE`.

echo "XML-extatom;      " \
  "all"     `grep -c "^deleting data/structures/all/XML-extatom/.*\.xml.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/XML-extatom/.*\.xml.gz$" $LOGFILE`.

echo "Structure factors;" \
  "all"     `grep -c "^deleting data/structures/all/structure_factors/.*\.ent.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/structures/divided/structure_factors/.*\.ent.gz$" $LOGFILE`.

echo "BioUnit;          " \
  "all"     `grep -c "^deleting data/biounit/coordinates/all/.*\.gz$" $LOGFILE`, \
  "divided" `grep -c "^deleting data/biounit/coordinates/divided/.*\.gz$" $LOGFILE`.



## OK!

echo
date

echo
echo UNZIPING!
echo

$BASEDIR/unzipPDB-v1.0.plx



## OK!

echo
date

echo
echo DONE!
