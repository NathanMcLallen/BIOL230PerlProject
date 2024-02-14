use File::Path qw( make_path rmtree ); 

# Deletes the output directory and re creates it

$dirToRemove = "./YeastGeneData";

rmtree($dirToRemove);

mkdir "YeastGeneData" or die "\n Please delete YeastGeneData first\n ";

# Opens directory for the while loop to read and prints a heading for the program to the screen

$dir = "YeastGenes";
opendir(InputFolder,$dir)or die "can't open gene directory $dir:$!";
print"\n";

print "GC content and number of acidic amino acids coded of S. cerevisiae / Scer yeast genes: \n";

#Goes through each gene and prints the DNA, GC content, and acidic AA's

#$counter = 0;
while ($filename = readdir InputFolder){

    # Skips . and .. in directory    
    next if $filename =~ /^\.{1,2}$/;

    # prints file name and opens input and output files
    
     $filelocation = "./YeastGenes/"."$filename";

     open (InputFile, $filelocation) or die "Cannot open file";

    open (OutputFile, ">"."./YeastGeneData/"."$filename") or die " could not open output file\n";     
    print "$filename \n";
    print OutputFile "$filename \n";

    # Skips first line of input file then  (testing only) prints the DNA sequence found in the second line
    $trash = <InputFile>;

    $DNAseq = <InputFile>;
   # print "$DNAseq \n";
   # print OutputFile "$DNAseq \n";


    #counts each nucleotide in the string then does the math needed to print the percentage of bases that are G or C
    $Gcount = 0;
    $Ccount = 0;
    $Acount = 0;
    $Tcount = 0;

    $Gcount = $DNAseq =~ tr/G//;
    $Ccount = $DNAseq =~ tr/C//;
    $Acount = $DNAseq =~ tr/A//;
    $Tcount = $DNAseq =~ tr/T//;

    $GCcount = $Gcount + $Ccount;
    $ATcount = $Acount + $Tcount;

   # print "$Gcount $Ccount $Tcount $Acount \n";        
   # print "$GCcount $ATcount\n";

    $GCdecimal = $GCcount / ($GCcount + $ATcount);
    $GCpercent = $GCdecimal * 100;
    print "GC content: "."$GCpercent"." % \n";
    print OutputFile "GC content: "."$GCpercent"." % \n";

    # Splits sequence into codons then reports the number of negatively charged amino acids coded


 @codons = $DNAseq =~ /(.{3})/g;
 # print "@codons \n";
 
 $acidCodons = "GA";
 $acidCount = 0;
 foreach (@codons){
    $firstTwo = substr($_, 0, 2);
    if ($firstTwo eq $acidCodons){ $acidCount++}
 }
 print "Number of negatively charged amino acids coded: "."$acidCount \n";
 print OutputFile "Number of negatively charged amino acids coded: "."$acidCount \n";



    # gets ready for next loop
    print "\n \n";
    close InputFile;
    close OutputFile;
  #  $counter++
}
#print "$counter"." genes analyzed\n";
print "end program\n";
exit;
