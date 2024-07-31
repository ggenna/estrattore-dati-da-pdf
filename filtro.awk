BEGIN{
filen=0
flag=0
 while(getline <"seleziona.txt" > 0)
   {
  #legge per riga
 	 for(i=1;i<=NF;i++)
 	 {
 	 vett_perole[$i]=0; 
 	 printf("%s\n",$i) >> "ecco.txt";
 	 }
  }
  



}
{ 
 #  FNR NUMERO D'ORDINE DEL FILE IN INGRESSO
	 if(FNR==1) 
	   { 
	     filen=filen+1;
	     if(filen==1)
	     {
	     printf("NOME, COGNOME\tINDIRIZZO\tTELEFONO\tMAIL\n") >> "nuovofile.txt";
	     }
	     
	     # printf("%d ",filen) >> "nuovofile.txt";
	      printf("\n") >> "nuovofile.txt";
	      
	      for(k in vett_perole)
	     {
	        vett_perole[k]=0;
	     }
	    }
 #OPPURE : ( FILENAME == ARGV[1] )
 

	   for(j=1;j<=NF;j++)
	   {  
	    for(k in vett_perole)
	     {
	    #  printf("file=%s seleziona=%s\n",toupper($j),k) >> "nuovofile.txt";
		    if(toupper($j) ~ toupper(k))
		    {
		    vett_perole[k]++;
		     if(vett_perole[k]<=1)
		     {
				flag=1;
				#print NR;
				#print NF;
		      for (h=j+1;h<=NF;h++)
		      #print $h;
			    printf("%s ",$h) >> "nuovofile.txt";
			    }
			  }
		 }
	   } 
	 if(flag==1)
	 {
	   flag=0;
	   printf("\t") >> "nuovofile.txt";
	 }

}	
END{
 printf("\n") >> "nuovofile.txt";
		printf("FINE") >> "nuovofile.txt";
	
}
# accetta una lista di file e conta quante volte le parole contenute 
# nel primo file della
# sono presenti nei rimanenti file
