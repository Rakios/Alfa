#include <stdio.h>              /* Standard buffered input/output        */
#include <stdlib.h>             /* Standard library functions            */
#include <string.h>             /* String operations                     */
#include <pthread.h>		/* Thread related functions		 */



typedef struct
{
	FILE* f1;
	FILE* f2;
} strut;



//compare integers - helper to qsort
int compare_ints(const void* a, const void* b){
	int* arg1 = (int*) a;
	int* arg2 = (int*) b;
	if( *arg1 < *arg2)
		return -1;
	else if(*arg1 == *arg2)
		return 0;
	else 
		return 1;
}



int getSize(char* f)
{
	unsigned int numLines = 0; 
	int number;
	
	FILE* file = fopen(f, "r");
	
	if (file == NULL)
	{
		perror("Cannot open file to get size.\n");
		return -1;
	}
	
	while(!feof(file))
	{
		fscanf(file,"%d",&number);
		numLines++;
	}
	
	fclose(file);
	
	//printf("File: %s Size: %d.\n", f, numLines);
	return numLines;
}


//sort file
void sortFile(void *ptr){
	char* filename;
	filename = (char*)ptr;
	
//	printf("filename:  %s\n",filename);
	
	//open file
	FILE * pFile;
	pFile = fopen (filename, "r");
	
	if(pFile==NULL)
	{
		printf("Didn't find file: %s\n",filename);
		fclose(pFile);
		exit(0);
	}
	
	//how big our array of numbers is
	unsigned int arrSize=getSize(filename)+2;
	
	int* numbers=(int*)malloc(arrSize*sizeof(int));
	numbers[arrSize-1]='\n';
	int numCount=0;  //count of numbers
	
	//get each line from line
	int n;
	
	
	//while still reading
	while(fscanf(pFile,"%d",&n) != EOF)
	{
		numbers[numCount]=n;
		numCount+=1;
	}
	
	//close file
	fclose(pFile);
	
	//sort array
	qsort(numbers,numCount,sizeof(int), compare_ints);
	

	//open output file
	char* oName=(char*)malloc((6+strlen(filename))*sizeof(char));
	
	//create and open a new file
	oName[0]='\0';
	strcat(oName,filename);
	strcat(oName,".sorted");
	pFile = fopen(oName, "w");


	if(pFile == NULL)
	{
		printf("failed to open output file\n");
		fclose(pFile);
		free(numbers);
		free(oName);
		exit(0);
	}

	
	//print out sorted array
	int i=0;
	while(i<numCount)
	{
		fprintf(pFile, "%d\n",numbers[i]);
		i+=1;
	}
	
	//print lines
	printf("This worker thread writes %d lines to \"%s\".\n", numCount,
			oName);

	//mem free
	fclose(pFile);
	free(numbers);
	free(oName);
	
	return;
}




//merge two consecutive files
void mergeFiles(void* param)
{
//	printf("starting merge\n");

	strut * f=(strut*)param;
	FILE* file1 = (*f).f1;
	FILE* file2 = (*f).f2;
	
	rewind(file1);
	rewind(file2);
	
	FILE* merged;
	merged = tmpfile();
	
	//printf("made tmpfile\n");
	
	//printf("null check.\n");
	if(merged == NULL)
	{
		printf("failed to open output file\n");
		
		return;
	}
	
	int num1 ;
	int num2 ;

	unsigned int numLines = 0;

	//while not eof of each file, compare ints and store into 
	//one file. (eliminate doubles)
	
	unsigned file1length=0;
	unsigned file2length=0;	
	
	fscanf(file1, "%d",&num1);
	fscanf(file2, "%d",&num2);
	
	//printf("starting while\n");
	
	while(!feof(file1) & !feof(file2))
	{
	//	printf("File1size: %d File2size: %d\n", file1length, file2length);
		if (num1 == num2)
		{
			fprintf(merged, "%d\n", num1);
			file1length+=1;
			file2length+=1;
			fscanf(file1,"%d",&num1);
			fscanf(file2,"%d",&num2);
		}
		else if(num1 < num2)
		{
			fprintf(merged, "%d\n",num1);
			file1length+=1;
			fscanf(file1,"%d",&num1);
		}
		else //num1 > num2
		{
			fprintf(merged, "%d\n", num2);
			file2length+=1;
			fscanf(file2,"%d",&num2);
		}
		numLines+=1;		
	}
	
	
	
	if(!feof(file2))
	{
		//added new here
		fprintf(merged,"%d\n",num2);
		
		file2length+=1;
		while(!feof(file2))
		{
			fscanf(file2,"%d",&num2);
			if(!feof(file2))
			{
				//printf("out: %d\n",num2);
				fprintf(merged,"%d\n",num2);
				numLines++;
				file2length++;
			}
		}
	}
	
	if(!feof(file1))
	{
		//added new here
		fprintf(merged,"%d\n",num1);		
		
		file1length+=1;
		while(!feof(file1))
		{
			//printf("File1size: %d File2size: %d\n", file1length, file2length);
			fscanf(file1,"%d",&num1);
			//printf("file1: %d\n",num1);
			if(!feof(file1))
			{
				//printf("out: %d\n",num1);
				fprintf(merged,"%d\n",num1);
				numLines++;
				file1length++;
			}
		}
	}
	rewind(merged);
	int k;
	
	while(!feof(merged))
	{
		fscanf(merged, "%d",&k);
	//	printf("%d\n",k);
	}		
	
	//print statement
	//the counts are off by one.  NOt sure why.
	numLines+=1;
	printf("Merged %d lines and %d lines into %d lines.\n", file1length, file2length, numLines);
	
	fclose(file1);
	fclose(file2);
	
	(*f).f1=merged;
	
}

//copies pFile to sorted.txt
void copy(FILE * pFile)
{
	rewind(pFile);
//	printf("starting file copy\n");
	if(pFile==NULL)
	{
		printf("NULL file pointer in copy!!\n");
		return;
	}
	
	//open output file
	FILE * oFile=fopen("sorted.txt","w");
	if(oFile==NULL)
	{
		printf("failed to open output file\n");
		return;
	}
	
	int n;
	//while still reading
	while(fscanf(pFile,"%d",&n) != EOF)
	{
		//printf("read: %d\n",n);
		fprintf(oFile, "%d\n",n);
	}
	
	//printf("finished printing to file\n");
	
	fclose(oFile);
	return;
}



int main(int argc, char **argv)
{
	if(argc <= 2)
	{
		printf("You didn't pass enough arguements.  Please enter 2 or more files\n");
		return 0;
 	}
	
	//char**arrFiles = (char**) malloc((argc-1)*sizeof(char*));

	// this all works and done
	pthread_t * threads=(pthread_t*)malloc(argc*sizeof(pthread_t));
	
	int i=1;
	//start running all the threads
	while(i<argc)
	{
		pthread_create(&threads[i-1],NULL,sortFile, argv[i]);
		i+=1;
	}
	
	//wait until they are all done
	i=1;
	while(i<argc)
	{
		pthread_join(threads[i-1],NULL);
		i+=1;
	}
	//now in untested stuff
		
	
	
/*/
/// test of merge this does everything ./mp2.1 a1.txt a2.txt - the threads
	FILE * one = fopen("a1.txt.sorted", "r");
	FILE * two = fopen("a2.txt.sorted", "r");
	int abc;
	fscanf(one,"%d",&abc);
	fscanf(one,"%d",&abc);
	
	strut a;
	a.f1=one;
	a.f2=two;
	a.x=5;

	mergeFiles(&a);
	copy(a.f1);
	printf("x is now: %d\n",a.x);
	*/
 
	
	//printf("starting untested stuff\n");
	
	i=1;
	//holds all the open file*
	FILE ** fileArr;
	fileArr=(FILE**)malloc(argc*sizeof(FILE*));

	//printf("starting file ptrs\n");
	//setup file pointers to each .sorted file	
	
	while(i<argc)
	{
		char* temp=(char*)malloc((strlen(argv[i])+10)*sizeof(char));
		temp[0]='\0';
		strcat(temp, argv[i]);
		strcat(temp, ".sorted");
		FILE * ptr=fopen(temp,"r");
		
		if(ptr==NULL)
		{
			printf("error opening file: %s\n",temp);
			free(temp);
			free(fileArr);
			exit(0);
		}
		
		//printf("added fileptr: %s\n",temp);
		fileArr[i-1]=ptr;
		free(temp);
		i+=1;
	}
	
//	printf("declaring threads\n");
	
	//all the threads working on combining files
	//pthread_t * moreThreads=(pthread_t*)malloc(argc*sizeof(pthread_t));
	
	int numFiles=argc-1;
	while(numFiles > 1)
	{
		int j=0;
		int counter=0;
				
		strut* struts=(strut*)malloc(argc*sizeof(strut));
		
		//printf("starting threads\n");
		//start a merge thread for each pair of files
		while((j+1) < numFiles)
		{
		//	printf("about to make thread %d\n",counter);
			struts[counter].f1=fileArr[j];
			struts[counter].f2=fileArr[j+1];
			//printf("about to create a thread\n");
			pthread_create(&(threads[counter]),NULL,mergeFiles, &(struts[counter]));
			j+=2;
			counter+=1;
		}
	
	//	printf("before joining threads\n");
		//wait for all the threads to be done
		j=0;
		counter=0;
		while((j+1) < numFiles)
		{
		//	printf("before checking NULL\n");
			if(threads[counter]==NULL)
			{
				printf("error found NULL thread\n");
				exit(0);
			}
		//	printf("counter:%d\n",counter);
			
			pthread_join(threads[counter],NULL);
			j+=2;
			counter+=1;
		}
		
		//printf("setting tempfiles\n");
		//collect all the new file pointers
		FILE ** tempFiles=(FILE**)malloc(numFiles*sizeof(FILE*));
		j=0;
		counter=0;
		while((j+1) < numFiles)
		{
			//printf("looping through tempFiles at %d\n",counter);
			tempFiles[counter]=struts[counter].f1;
			j+=2;
			counter+=1;
		}
		
		//if we missed one
		if(numFiles%2==1)
		{
			//printf("adding missed guy");
			//printf("at: %d\n",counter);
			tempFiles[counter]=fileArr[numFiles-1];
			counter+=1;
		}
		
		//change the number of files
		numFiles=counter;
		free(fileArr);
		fileArr=tempFiles;
		
		free(struts);
		
	}
	 
	free(threads);
	free(fileArr);
	//copy fileArr[0] -> sorted.txt
	copy(fileArr[0]);
	fclose(fileArr[0]);
	
	/**/ //make live easy
	
	return 0;
}