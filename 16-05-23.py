import numpy as np
#Here's my solution for the May 16 AngelHack code challenge. This one is written in Python.
#My answer is 32509983.
#
#I want to say a word on how I'm storing the grids. The problem involves 5 by 5 grids. Everything
#outside the edges are considered not alive. I'm actually using 7 by 7 grids. The actual active
#grid is the part from n=1 to 5. There is a border that is not alive, in rows 0 and 6 as
#well as columns 0 and 6.


blankGrid=np.zeros([7,7], dtype=int)
testGrid=np.zeros([7,7], dtype=int)
startGrid=np.zeros([7,7], dtype=int)
oldGrid=np.zeros([7,7], dtype=int)
newGrid=np.zeros([7,7], dtype=int)
sampleSSGrid=np.zeros([7,7], dtype=int)
allOldGrid=np.zeros([100,7,7], dtype=int)
scoreGrid=np.array([[0,0,0,0,0,0,0],[0,0,1,2,3,4,0],[0,5,6,7,8,9,0],[0,10,11,12,13,14,0], \
                    [0,15,16,17,18,19,0],[0,20,21,22,23,24,0],[0,0,0,0,0,0,0]])


#Define startingPatterns
def startingPatterns():
    testGrid[1][5]=1
    testGrid[2][1]=1
    testGrid[2][4]=1
    testGrid[3][1]=1
    testGrid[3][4]=1
    testGrid[3][5]=1
    testGrid[4][3]=1
    testGrid[5][1]=1
    startGrid[1][1]=1
    startGrid[1][2]=1
    startGrid[1][3]=1
    startGrid[1][4]=1
    startGrid[2][1]=1
    startGrid[3][1]=1
    startGrid[3][4]=1
    startGrid[4][2]=1
    startGrid[4][4]=1
    startGrid[5][1]=1
    startGrid[5][2]=1
    startGrid[5][4]=1
    startGrid[5][5]=1
    sampleSSGrid[4][1]=1
    sampleSSGrid[5][2]=1
    
    
def evolvePoint(center, up, down, left, right):
    newCenter=0
    neighborCount=up+down+left+right
    if center==0:
        #current cell is not alive
        #newCenter will be alive if 1 or 2 neighbors are alive
        if((neighborCount==1)or(neighborCount==2)):
            newCenter=1
        else:
            newCenter=0    
    elif center==1:
        #current cell is alive
        #newCenter will be alive if exactly 1 of up, down, left, and right are 1
        if neighborCount==1:
            newCenter=1
        else:
            newCenter=0
    else:
        print('Zombie, cell is neither dead or alive')
    return newCenter


def evolveGrid(inGrid):
    tempGrid=np.zeros([7,7], dtype=int)
    for ii in range (1,6):
        for jj in range (1,6):
            tempGrid[ii][jj]=evolvePoint \
                    (inGrid[ii][jj], inGrid[ii-1][jj], inGrid[ii+1][jj], \
                     inGrid[ii][jj-1],inGrid[ii][jj+1])
    #print(tempGrid)
    return tempGrid

def scoreMe(inGrid):
    scoreValue=0
    for pp in range(1,6):
        for qq in range (1,6):
            if(inGrid[pp][qq]==1):
                scoreValue=scoreValue+(2**scoreGrid[pp][qq])
    return scoreValue


#Here's the main function.
def main():
    print("Hello")
    stillGoing=0 #A 0 means we have not yet found the first match. A 1 means we have
    score=0
    maxKK=100
    startingPatterns()
    oldGrid=np.copy(startGrid)
    print('Starting grid \n')
    print(startGrid)
    print('\n')
    allOldGrid[0]=np.copy(oldGrid)
    kk=1
    
    while((kk<maxKK)and(stillGoing==0)):
        kk=kk+1
        #Evolve the grid and remember it.
        newGrid=evolveGrid(oldGrid)
        allOldGrid[kk]=np.copy(newGrid)
        #Now check all the old copies... Have we found a match yet?
        for ii in range(kk):    
            if (np.array_equal(allOldGrid[ii], newGrid)==True):
                print("Match at kk=",kk,"   and ii=",ii)
                print(newGrid)
                score=scoreMe(newGrid)
                print("score=",score)
                stillGoing=1 
        oldGrid=np.copy(newGrid)   
    print("Bye")
    return
    

#run main
main()
