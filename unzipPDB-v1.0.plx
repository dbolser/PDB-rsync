#!/usr/bin/perl -w

## Unzip the PDB. We ignore the 'divided' sections. See the 'unzipIt'
## function if you really want to fix that.

use strict;

## Directories
my $bDir = "/project/StruPPi/BiO/DBd/PDB-REMEDIATED";
my $inDir = "$bDir/data/structures/all";
my $outDir = "$bDir/data/structures/unzipped/all";

## Divisions to unzip;
my @division = qw(
  pdb
  mmCIF
);

## How Verbose to be (0 or 1 or 2),
## 0 = silent
## 1 = print activity stats (per division)
## 2 = print all actions

my $verbose = 1;



## This method is slow but sure. It avoids messing around with
## '$bDir/data/status' files and seems to do a good job of
## incrementally updating the unzipped files.

## For each division...
foreach (@division){
  print "doing $inDir/$_\n"
    if $verbose > 0;
  
  ## Read all the files listed within...
  opendir( DIR, "$inDir/$_" )
    or die "cant open directory $inDir/$_ : $! \n";
  
  my (%file, @new, @upd, @obs);
  
  while (my $inFile = readdir( DIR )){
    next if $inFile eq '.';
    next if $inFile eq '..';
    
    unless($inFile=~/^(.*)\.(?:Z|gz)$/){
      print "what is this : $inFile ? skipping ! \n"
	if $verbose > 0;
      next;
    }
    my $outFile = $1;
    
    $file{$outFile}++;
    
    ## Get the file stats (implicit tests for file existence);
    my @inStats = stat( "$inDir/$_/$inFile" );
    my @outStats = stat( "$outDir/$_/$outFile" );
    
    ## OK, here comes the logic...
    
    ## If file exists and
    if(@outStats){
      ## if mod times mod times are *not* equal...
      if($inStats[9] != $outStats[9]){
	## unzip the file!
	unzipIt( "$inDir/$_/$inFile", "$outDir/$_/$outFile" );
	push(@upd, $outFile);
      }
      else{
	## Nothing to do, mod times *are* equal (see unzipIt).
	next;
      }
    }
    ## File does not exist - we need to unzip!
    else{
      ## unzip the file!
      unzipIt( "$inDir/$_/$inFile", "$outDir/$_/$outFile" );
      push(@new, $outFile);
    }
    ##exit;
  }
  
  ## Finally we remove files that are no longer present
  opendir( DIR, "$outDir/$_" )
    or die "cant open directory $outDir/$_ : $! \n";
  
  while (my $outFile = readdir( DIR )){
    next if $outFile eq '.';
    next if $outFile eq '..';
    
    unless($file{$outFile}){
      print "removing (old) $outDir/$_/$outFile\n"
	if $verbose > 1;
      
      system( "rm $outDir/$_/$outFile" )
	and die "rm killed by $?\n";
      push(@obs, $outFile);
    }
  }
  
  # Print some stats and...
  if ($verbose > 0){
    print " While unzipping I found...\n";
    printf " %6d      new PDB files\n", scalar(@new);
    printf " %6d  updated PDB files\n", scalar(@upd);
    printf " %6d obsolete PDB files\n", scalar(@obs);
  }
  # Process the next division.
}



## Subroutines

sub unzipIt {
  my $inFile = shift;
  my $outFile = shift;
  
  my $cmd = "gunzip -fc $inFile > $outFile";
  
  print "doing $cmd\n"
    if $verbose > 1;
  
  system( $cmd )
    and die "gunzip killed by $?\n";
  
  ## IMPORTANT! Here we set the access and modification times of
  ## $outFile to those of $inFile. The inode change time of $outFile
  ## is set to the current time. This step is the basis of the
  ## synchronization algorithm! NOTE: (please (watch (your ()()())))
  
  utime (((stat $inFile)[8]), ((stat $inFile)[9]), $outFile)
    or die "cant modify file $outFile : $! \n";
}


