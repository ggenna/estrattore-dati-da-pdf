filtro="./filtro.awk"
seleziona="./seleziona.txt"
somma=0
numero=1




if [ ! -e "$filtro" ]
then
 echo "$filtro not found"
 exit 1
fi

if [ ! -e "$seleziona" ]
then
 echo "$seleziona not found"
 echo "Usage: $seleziona contains the string patterns to be selected"
 exit 1
fi


if [ $# -eq 2 ] 
 then
if [ $2 == "ocr" ] || [ $2 == "text" ]  
then
 
 
IFS=$'\n'
	mkdir tempconvert
	cp -r $1/ tempconvert/

	for i in $(find $1 -name "*.pdf")
 	do
 	mv $i $(echo  $i | tr ' ' '-')
	done
#	IFS=$' '

	for i in $(find $1 -name "*.pdf") 
	do
	let "somma = $somma + $numero"
	
	
	
	file=$(echo $i | sed 's/.pdf/.tif/')
	testo=$(echo $i | sed 's/.pdf//')
	#echo $file
	#echo $testo
	#   echo $i | sed 's/\ /\\\ /'  >> prova.txt
	
	if [ ! -d "$(dirname $testo)/converted" ]
	then
	  mkdir $(dirname $testo)/converted
	fi
	
	if [ $2 == "ocr" ]
	then
	
	echo "convert to tif file: $i"
	convert -density 400 -units PixelsPerInch -type Grayscale -depth 8 $i $file
	# Adesso convert si usa per i PNG e gs per i tiff
	# gs -dNOPAUSE -q -r500 -sDEVICE=tiffg4 -dBATCH -sOutputFile=$file $i
	echo "convert to txt file: $file"
	tesseract $file $testo -l ita
	echo "file $testo.txt created"
	
	mv $testo.txt $(dirname $testo)/converted/$somma.txt

    else

    if [ $2 == "text" ]
    then
	 pdftotext -f 1 $i $(dirname $testo)/converted/$somma.txt
	fi
	
	fi

	done 
else
 echo "Usage: $0 path_pdf_files ocr/text "
 exit 1
 
fi
else
	echo "error num arg $#"
	echo "Usage: $0 path_pdf_files ocr/text "
	exit 1
fi
#echo $(find $1/converted -name "*.txt")

awk -f filtro.awk  $(find $1/converted -name "*.txt")
mv nuovofile.txt elenco.xls
echo "file elenco.xls created"


rm -R $1/
mv tempconvert/ $1/
 
 exit 0