//Here's part 2...

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
	int seconds=1234;
	int secCount=0;
	int playerCount=0;
	char names[6][20];
	int speeds[6]={10, 8, 12, 7,9,5};
	int restMaxTime[6]={20,25,16,23,32,18};
	int runMaxTime[6]={6,8,5,7,4,9};
	int currTime[6]={0,0,0,0,0,0}; 
	int running[6]={1,1,1,1,1,1};
	int distance[6]={0,0,0,0,0,0};
	//1=running 0=resting
	strcpy(names[0], "John");
	strcpy(names[1], "James");
	strcpy(names[2], "Jenna");
	strcpy(names[3], "Josh");
	strcpy(names[4], "Jacob");
	strcpy(names[5], "Jerry");

	for (playerCount=0;playerCount<6; playerCount++)
	{
		for(secCount=1; secCount<=seconds;secCount++)
		{
			currTime[playerCount]++;
			if(running[playerCount]==1)
			{
				//running
				distance[playerCount]=distance[playerCount]+speeds[playerCount];
				if(currTime[playerCount]==runMaxTime[playerCount])
				{
					//stop running
					running[playerCount]=0;
					currTime[playerCount]=0; 
				}
			
			}
			else
			{

				//resting
				if(currTime[playerCount]==restMaxTime[playerCount])
				{
					//start running
					running[playerCount]=1;
					currTime[playerCount]=0;
			}
	  

		}
		}
			printf("%s %d \n", names[playerCount], distance[playerCount]);
	
		}

	return 0;
}
