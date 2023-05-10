/*This code is written by Andy Mitofsky. It goes along with the May 10
Angelhack contest. It isn't really part of my solution. The java code
is my solution for that contest. I used this code to spot check my answer.
The entire list was too long to use this strategy. Instead, I used subsets 
of the list to verify my answer. 
*/
workersStarting=[1, 2, 3, 7, 12, 13, 15, 23, 24, 31, 32, 35, 42, 45, 52, 54, 56, 57, 79, 93, 99, 101, 104, 111, 113, 123, 123, 129, 135, 232, 335, 554, 611, 666, 677, 712, 876, 904, 997];
workers1=[ 3, 7,  15, 23, 24, 31, 32, 35, 42, 45];
workers2= [93, 99, 101, 104, 111, 113,129, 135];
workers3=[997, 232,335,554, 611,  712, 876, 904 ];
workers4=[1,2,12,13,52,54,56,57, 666,677]; 

workersOriginal=workers1;
workersAll=perms(workersOriginal,"unique");
allcombos=size(workersAll)(1)
listlen=length(workersOriginal)

score=0;
bestScore=100000;
bestii=0;
    
    //get nearest neighbors and find the score
    for ii=1:allcombos
     score=0;
        workers=workersAll(ii,:);
        //pick off nearest neighbors to get score
        for jj=1:2:listlen-1
         score=score+abs(workers(jj+1)-workers(jj));
        end
        if(score<bestScore)
         bestScore=score
         //bestii=ii;
         workers        
        end
    end
    //workersAll(bestii,:)
 

