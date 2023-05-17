# AH_May_AM
Here's my entry for the May 2023 AngelHack competition.

To make this a bit more fun, I'm going to try to write each entry in a different language.

The May 4 entry is written in Lua.
To get a lua compiler on an Ubuntu Linux box, use 

	sudo apt install lua5.3

The May 6 entry is written in Fortran.
To get a fortran compiler on an Ubuntu Linux box, use

	sudo apt-get install gfortran

The May 8 solution is written in Javascript embedded in html. 
You can just open the solution in a web browser.

The May 10 solution is written in Java. My solution is in the file Solution_10_5_2023.java.
Use something like the following to install a java compiler, compile,  and run the program:

	sudo apt install openjdk-11-jdk-headless

	javac Solution_10_5_2023.java

	java Solution_10_5_2023

I changed file naming conventions here because java class names must start with a letter.
the file may10_checker.sce is not part of my solution, but I included it anyways. I
wrote a little scilab script to double check my answer. As it is written, it doesn't 
give the actual score. However, I used it to calculate the score of subsets of the answer
to verify my Java code. My java code is the actual solution. 

The May 12 solution is written in Perl and uses regexes. Perl was preinstalled on my linux box, so to run I I just had to do something like:

	perl 12-05-23.pl

The May 14 solution is written in C++. I'm not quite sure I got the minimum score, but I think I got a good score. You can compile and run it with something like:

	g++ 14-05-23.cpp -0 14-05-23.o

	./14-05-23.o
	 

May 16 - OK, so I found a better solution for puzzle 6 from May 14. I moved the original code to the file named may14OldVersion.cpp in case you want to take a look. My current answer for the minimum value is 78. I'm even less confident in this answer than I was before. Also, I don't really like my code, because it is specific to the input string and not general. However, the problem asks for the minimum value, not general code.

The May 16 solution is written in Python. 
