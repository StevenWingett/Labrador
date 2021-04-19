mkdir FASTQ
mkdir BAM
mkdir REPORTS
mkdir ANALYSIS

mv *.fastq.gz FASTQ/
mv *.bam BAM/
mv *.html REPORTS/
mv *.txt REPORTS/
mv *.svg REPORTS/
mv *.png REPORTS/
mv multiqc_data/ REPORTS/
mv *_fastqc.zip REPORTS/
mv *.smk ANALYSIS/

