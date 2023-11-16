#Crear directorio
mkdir -p res/genome
#Descargar genoma
wget -O res/genome/ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
#Descomprimir
gunzip res/genome/ecoli.fasta.gz
#indexing code goes here
echo "Running STAR index..."
    mkdir -p res/genome/star_index
    STAR --runThreadN 4 --runMode genomeGenerate --genomeDir res/genome/star_index/ --genomeFastaFiles res/genome/ecoli.fasta --genomeSAindexNbases 9

#call analyse_sample for each sampleid

for sampleid in $(ls data/*.fastq.gz | cut -d"_" -f1 | cut -d"/" -f2 | sort | uniq)
do

#Execute FastQC
echo "Running FastQC..."
    mkdir -p out/fastqc
    fastqc -o out/fastqc data/$sampleid*.fastq.gz
    echo

done
