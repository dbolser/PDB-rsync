#!/bin/sh

export RCSBROOT=/project/StruPPi/Software/ciftr-v2.053-prod-bin-linux
export PATH="$RCSBROOT/bin:"$PATH

#for i in data/structures/all/mmCIF/1dan.cif.Z; do
for i in `find data/structures/all/mmCIF -name "*.cif.Z"`; do
    #echo "$i -> data/structures/all/mmCIF2PDB";
    CIFTr -i $i -IUPAC_H_ATOMS \
	-output_path data/structures/all/mmCIF2PDB \
	-uncompress "gunzip";
done;
