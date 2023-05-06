program try1
implicit none
        !Here's my entry for the May 6 programming challenge. It was written by Andy Mitofsky
        !This is written in Fortran. It has been a LONG time since I've programmed in Fortran. Time to get the rust out.
        !I hear you... you're saying algorithms contests are all about speed. Well, this should win for the longest time
        !needed, if you include the time to find your Fortran compiler. 
        !The max distance is 3540 by Jenna.
        integer :: seconds
        integer :: secCount
        integer :: playerCount
        integer :: maxDistance
        integer, dimension(6,20) ::names
        integer, dimension(6) ::speeds
        integer, dimension(6) ::restMaxTime
        integer, dimension(6) ::runMaxTime
        integer, dimension(6) :: currTime
        integer, dimension(6) ::running  !1=running, 0=resting
        integer, dimension(6) ::distance

        seconds=1234
        secCount=0
        playerCount=0
        maxDistance=0
        speeds = (/10,8,12,7,9,5/)
        restMaxTime = (/20,25,16,23,32,18/)
        runMaxTime=(/6,8,5,7,4,9/)
        currTime = (/0,0,0,0,0,0/)
        running=(/1,1,1,1,1,1/)
        distance=(/0,0,0,0,0,0/)
       

        do playerCount=1, 6
        !Loop over all six players

                do secCount=1,seconds
                !loop over all seconds
                        currTime(playerCount)=currTime(playerCount)+1
                        if(running(playerCount)==1) then
                                !running
                                distance(playerCount)=distance(playerCount)+speeds(playerCount);
                                if(currTime(playerCount)==runMaxTime(playerCount)) then
                                        !stop running
                                        running(playerCount)=0
                                        currTime(playerCount)=0
                                end if

                        else
                                !resting
                                if(currTime(playerCount)==restMaxTime(playerCount)) then
                                        !start running
                                        running(playerCount)=1
                                        currTime(playerCount)=0
                                end if
                        end if 
                end do
                print *, 'Player', playerCount, 'distance=', distance(playerCount) 
                if(distance(playerCount)>maxDistance) then
                         maxDistance=distance(playerCount)
                end if
        end do
        print *, 'The maximum distance a player ran is ', maxDistance 
        

end program try1 
