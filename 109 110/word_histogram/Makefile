## generating png relays on tsv , so dont need to put all of tsv and png
all: report.html

## rm: remove
clean: 
	rm -f words.txt histogram.tsv histogram.png report.html


## \ next line
words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
	
histogram.tsv: histogram.R words.txt
	Rscript histogram.R

## $@ is short for the target and $< is short for the first input	
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm -f Rplots.pdf
	
# plots: histogram.png hist2.png

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'