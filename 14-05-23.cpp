#include <iostream>
#include <string>
/* This solves the May 14 Angelhack puzzle challenge. It was written in C++ by Andy 
 * Mitofsky. I get a minimum score of 80. I'm not too confident this is the best
 * possible solution, though.
 *
 * This code assumes the initial string only has lowercase letters in it.
 * The lower case letters have ascii valuses 97 to 122 in decimal. The functions should 
 * be fairly general. However, the main loop is somewhat specific to the starting string.
 * If you have a different starting string, you'll have to tweak it a bit.
 * Also, I print most, but not every, step. I print a lot so hopefully this is enough for you to follow along.
 *
 * May 16 update: I found a better solution, with a score of 78. 
 * Somehow I'm less confident of this version than the last. I don't 
 * really like this solution, though, because it is less general than my previous 
 * solution. I'm submitting it anyways because the problem aske for the minimum, not
 * a general solution. 
 */

using namespace std;
//Declare my functions here
string findAA(string aStr);
string removeSolos(string bStr);
string findABA(string dStr);
string dropTwos(string fStr);
string dropS(string jStr);
string dropLoc(string jStr, int loc);


//Declare some variables we'll need
string dropFourAt(string jStr, int loc);
string dropThreeAt(string jStr, int loc);
int score=0; 
int ASCIIMIN=97;
int ASCIIMAX=122;

//The main function is here.
int main()
{
	string workingStr;
	string startingStr="kjslaqpwoereeeeewwwefifjdksjdfhjdksdjfkdfdlddkjdjfjfjfjjjjfjffnefhkjgefkgjefkjgkefjekihutrieruhigtefhgbjkkkknbmssdsdsfdvneurghiueor";
	cout<<"Starting string= "<<startingStr<<endl;
	workingStr=startingStr;
	workingStr=removeSolos( workingStr);
	workingStr=findAA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=dropTwos(workingStr);
	cout<<endl<<"POINT XXX score="<<score<<endl<<endl;
	workingStr=dropS(workingStr);
	workingStr=findABA(workingStr);
	workingStr=dropFourAt(workingStr, 46);
	workingStr=dropFourAt(workingStr, 56);
	workingStr=dropTwos(workingStr);
	workingStr=findABA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=dropThreeAt(workingStr,27);
	workingStr=dropFourAt(workingStr, 7);
	workingStr=findAA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=dropTwos(workingStr);
	workingStr=dropFourAt(workingStr,34);
	workingStr=dropFourAt(workingStr,24);
	workingStr=findAA(workingStr);
        workingStr=findABA(workingStr);
        workingStr=dropFourAt(workingStr,17);
	workingStr=dropLoc(workingStr, 16);
	workingStr=dropLoc(workingStr,16);
	workingStr=findAA(workingStr);
	workingStr=findAA(workingStr);
	workingStr=findABA(workingStr);
	workingStr=dropFourAt(workingStr,7);
	workingStr=dropFourAt(workingStr,5);
	workingStr=findABA(workingStr);
	workingStr=findAA(workingStr);	
	cout<<"Score="<<score<<endl;
	return 0;
}


string findAA(string aStr)
{
	//This function replaces AA with A. This doesn't at all affect the score because
	//removing AA and A are equivalent. 
	char aChar='0';
	char *aCharPtr;
	string twoChar="ee";
	aCharPtr=&aChar;
	int aLength=aStr.length();
	int jj;
	size_t startPt;
	size_t foundFirst=string::npos;
	cout<<"Removing Dupes"<<endl;
	string newStr=aStr;
	//loop over every letter...
	for(int ii=ASCIIMIN;ii<=ASCIIMAX;ii++)
	{
		aChar=(char)ii;
		twoChar.clear();
		twoChar.push_back(aChar);
		twoChar.push_back(aChar);
		//We may have to repeat this as many times 
		for(jj=0;jj<aLength;jj++)
		{
			foundFirst=newStr.find(twoChar);
			if(foundFirst!=string::npos)
			{
				//found a match. replace it
				cout<<"findAA found and removed "<<aChar<<endl;
				newStr.erase(foundFirst,1);
			}
		}
	};
	cout<<"findAA score="<<score<<"   "<<newStr<<endl;
	newStr=removeSolos(newStr);
	return newStr;

}


string removeSolos( string bStr)
{
	//This function looks for a letter that only appears once in the string.
	//If it finds a solo letter, the letter is removed and the score is incremented by 1.
	cout<<"Removing Solos"<<endl;
	char bChar='0';
	string oneChar;
	char *bCharPtr;
	bCharPtr=&bChar;
	size_t foundFirst=string::npos;
	size_t foundSecond=string::npos;
	string newStr=bStr;
	string oldStr=bStr;
	for(int ii=ASCIIMIN;ii<=ASCIIMAX;ii++)
	{
		bChar=(char)ii;
		oneChar.clear();
		oneChar.push_back(bChar);
		oldStr=newStr;
		foundFirst=newStr.find(oneChar);
		if(foundFirst!=string::npos)
		{
			//we found one match... Let's get rid of it
			newStr.erase(foundFirst,1);
			//Do we find a second? If so, put it back.
			foundSecond=newStr.find(oneChar);
			if(foundSecond!=string::npos)
			{
				//We found two ... better return the original
				newStr=oldStr;
			}
			else
			{
				//we only found one
				cout<<"Removing the Solo="<<bChar<<endl;
				score++;
			}
		}
		//For debug purposes, let's spill out what we're doing.
		//cout<<"AfterSolo="<<score<<"   "<<newStr<<endl;
	}
	cout<<"After solo score="<<score<<"  "<<newStr<<endl;
	return newStr;
}


string findABA(string dStr)
{
	//This function looks for the pattern ABA. If so, it is replaced by A, and the score is 
	//incremented by 1.
	cout<<"Finding ABA's"<<endl;
	int dLength=dStr.length();
	int kmax=dLength-2;
	for(int kk=0;kk<kmax;kk++)
	{
		if(dStr.at(kk)==dStr.at(kk+2))
		{
			cout<<"Removing ABA="<<dStr.at(kk)<<dStr.at(kk+1)<<dStr.at(kk+2)<<endl;
			dStr.erase(kk,2);
			kmax=kmax-2;
			kk--; //recheck the point you're at
			score++;
		}
	}
	cout<<"findABA score="<<score<<"    "<<dStr<<endl;
	dStr=findAA(dStr);
	return dStr;
}



string dropTwos(string fStr)
{
	//This function checks if a character only appears twice. If so, it is 
	//dropped both times and the score is incremented by 2.
	//It also checks for the special case when there are only two A's and the pattern
	// AB...BA appears. If so, it doesn't drop A.
	cout<<"Dropping twos"<<endl;
	//Check if a letter appears only twice. if so, drop it
	int fLength=fStr.length();
	char fChar;
	char *fCharPtr;
	string fLetter;
	fCharPtr=&fChar;
	size_t findFirst=string::npos;
	size_t findNext=string::npos;
	int pmax=fLength;
	int fCount=0;
	int specialCase=0;
	size_t findOne=string::npos;
	size_t findTwo=string::npos;
	for(int nn=ASCIIMIN;nn<=ASCIIMAX;nn++)
	{
		fChar=(char)nn;
		fCount=0;
		fLetter.clear();
		fLetter.push_back(fChar);
		specialCase=0;
		for(int pp=0;pp<pmax;pp++)
		{
			if(fStr.at(pp)==fChar)
			{
				fCount++;
			}
		}
		
		//Also... I'm assuming the two aren't next to each other...
		if(fCount==2)
		{
			findFirst=fStr.find(fLetter);
                        findNext=fStr.find(fLetter, findFirst+1);

			if(fStr.at(findFirst+1)==(fStr.at(findNext-1)))
			{
				specialCase=1;
				cout<<"We have two, but don't drop the special case="<<fChar<<endl;
			}
			//FUDGING HERE
			if(fChar=='u') 
			{
				specialCase=1;
			}

			if(specialCase==0)
			{
				//We have exactly 2, and we don't have the special case.
				pmax=pmax-2;
				cout<<"We have exactly two, so drop "<<fChar<<endl;
			
				//We know there are two so drop them.
				findFirst=fStr.find(fLetter);
				findNext=fStr.find(fLetter, findFirst+1);
				//cout<<"First at "<<findFirst;
				//cout<<"   Next at "<<findNext<<endl; 
				fStr=fStr.erase(findFirst,1);
				findFirst=fStr.find(fLetter);
				fStr=fStr.erase(findFirst,1);
				score=score+2;
				cout<<fStr<<endl;
			}
		}
	}
	cout<<"score="<<score<<"   "<<fStr<<endl;
	return fStr;
}


string dropS(string jStr)
{
	//This function drops all S's and increments the score.
	cout<<"DROPPING S"<<endl;
	int jLength=jStr.length();
	size_t foundLoc=string::npos;
	for(int jj=0;jj<4;jj++)
	{
		foundLoc=jStr.find("s");
		if(foundLoc!=string::npos)
			{jStr.erase(foundLoc,1);
			 score++;
			}
		
	}
	cout<<"score="<<score<<"   "<<jStr<<endl;
	return jStr;
}


string dropLoc(string jStr, int loc)
{
	//This function drops one letter and increments the score by one.
        cout<<"Dropping At location="<<loc<<endl;
        int jLength=jStr.length();
        jStr.erase(loc-1,1); 
	score++;
        cout<<"score="<<score<<"  "<<jStr<<endl;
        return jStr;
}




string dropFourAt(string jStr, int loc)
{
	//This function drops four letters either in the form ABCA or ABAC. In either case
	//this raises the score by 3, so I can use this for both types of four letter strings.
	cout<<"DROPPING FOUR IN A ROW ABCA="<<jStr.at(loc-1)<<jStr.at(loc)<<jStr.at(loc+1)<<jStr.at(loc+2)<<endl;
	score=score+3;
	jStr.erase(loc-1,4);
	cout<<"score="<<score<<"   "<<jStr<<endl;
	return jStr;

};


string dropThreeAt(string jStr, int loc)
{
	//This function drops three letters at the specified location and increases
	//the score by 3.
	cout<<"DROPPING THREE ABC="<<jStr.at(loc-1)<<jStr.at(loc)<<jStr.at(loc+1)<<endl;
	score=score+3;
	jStr.erase(loc-1,3);
	cout<<"score="<<score<<"  "<<jStr<<endl;
	return jStr;
}
