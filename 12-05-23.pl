#!/usr/bin/perl

#This code is written by Andy Mitofsky.
#It is written in perl and uses regexes.
#It solves the May 12 Angelhack code contest.
#The answer is "i love angelhack code challenge because it is fun and 
#exciting and i dislike the word yab that appears in the phrase."
#
#It has been a while since I've coded in Perl, but not as long as since I've 
#coded in Fortran.
#
#The answer here is not unique. More than one solution is possible. 
#For example, a space is equivalent to the phrase yab.
#For the answer, I replace any string of three spaces with space-yab-space.
#
#I used a few references in this solution...
##The problem asks you to write a function which takes a string and a dictionary. 
#This was tricky. I found help from stackoverflow here at
#https://stackoverflow.com/questions/4893113/how-do-i-pass-a-hash-to-subroutine
#I used a list of the frequency of letters in English from
#https://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
#I used a list of the most common words in English from
#https://en.wikipedia.org/wiki/Most_common_words_in_English
#I also used the Perl tutorial at 
#https://www.tutorialspoint.com/perl/index.htm

#Let's set some starting parameters
#Set starting string from the problem
$testMsg="01010001011010101010101";
$ahMsg="11111011111111110001111111001011111101011111111100110111111111110001001111110100111100110111111100101111010010111111000111111111110001101111110101110011011111111111000110111101001111110010111111001011011111110100111100110111111111110001011101100011111110111111111001110111111111110001111110111111101011111111110001111110111111100111111111110001111011111110111111110100111111111100010011111101001100111111111100011101111111111010111110111111101011111011111101001111001111111111000100111111010011001111111111000111111011111111110001110011111011111110011111110010111110111111000111011111111111000111111110101111011101111111111100011111111101111111010111111110001100111111111100011111111111000111111111110001111111101011110100111111101011111111110001001111110110111111011011010011111110001111111001111111111100011111101111110100111111111100011111111010111101110111111111110001111111011011110111111110000011111110011101";


#Here's the dictionary from the problem. In perl, it is a hash.
%ahDictionary=('a' => '00',
	'b'=> '01',
	'c'=> '10',
	'd'=>'1100',
	'e'=>'1101',
	'f'=>'1110',
	'g'=>'111100',
	'h'=>'111101',
	'i'=>'111110',
	'j'=>'1111110000',
	'k'=>'1111110001',
	'l'=>'1111110010',
	'm'=>'1111110011',
	'n'=>'1111110100',
	'o'=>'1111110101',
	'p'=>'1111110110',
	'q'=>'1111110111',
	'r'=>'1111111000',
	's'=>'1111111001',
	't'=>'1111111010',
	'u'=>'1111111011',
	'v'=>'1111111100',
	'w'=>'1111111101',
	'x'=>'1111111110',
	'y'=>'1111111111',
	'z'=>'1111111110000',
	' '=>'1111111110001');

#Here's an array of the letters that we'll look for. It is in a particular order. 
#Notice the that code words have an even length. More specifically, 
#lengths are 2,4,6,10, or 14 only. I've sorted the letters first by the length 
#of their corresponding code word then by their frequency according to the reference 
#cited above.
@letterF=(' ', 'z','t', 'o', 'n', 's', 'r', 'l', 'u', 'm', 'y', 'w', 'p', 'v', 'k', 'x', 'q', 'j', 'i', 'h', 'g', 'e', 'd', 'f', 'a', 'c', 'b');
#The array above is useful for decoding most, but not all, of the letters. 
#So, we'll try again by searching for letters in a different order. 
#This second list again sorts letters first by length and then by frequency. 
#However, the letters t, s, m, f, and a are purposely checked later than in the previous list.  Also, x is checked earlier.
#For a more thorough solution, we should try all possible letter frequencies. 
#However, these two lists are enough to crack the message entirely. So, I'll 
#save that for another day.
@letterF2=(' ', 'z', 'x', 'o','n',  'r', 'l', 'u', 'y', 'p', 'v', 'k','x', 'q', 'j',  'w', 't', 's', 'm','i', 'h', 'g',  'e', 'd',  'f', 'c', 'b','a');
#$dictLength=28;

#I start the algorithm by checking for the 20 most common words in the English
#language... and angelhack. Note this is a hash, so I don't know the order
#that these will be checked in.
%commonWordHash=(' the '=>'111111111100011111111010111101110111111111110001',
        ' be ' => '1111111111000101110111111111110001',
        ' to '=> '11111111110001111111010111111010111111111110001',
        ' of '=> '111111111100011111110101111011111111110001',
        ' and '=> '11111111110001001111110100110011111111110001',
        ' a ' => '111111111100010011111111110001',
        ' in '=> '11111111110001111110111111010011111111110001',
        ' that '=> '11111111110001111111101011110100111111101011111111110001',
        ' have '=> '11111111110001111101001111111100110111111111110001',
        ' i ' => '1111111111000111111011111111110001',
        ' it ' => '11111111110001111110111111101011111111110001',
        ' for ' => '1111111111000111101111110101111111100011111111110001',
        ' not ' => '1111111111000111111101001111110101111111101011111111110001',
        ' on ' => '111111111100011111110101111111010011111111110001',
        ' with '=>'1111111111000111111111011111101111111010111110111111111110001',
        ' he '=> '11111111110001111101110111111111110001',
        ' as ' => '1111111111000100111111100111111111110001',
        ' you '=> '11111111110001111111111111111010111111110111111111111001',
        ' do '=> '111111111100011100111111010111111111110001',
        ' at '=> '1111111111000100111111101011111111110001',
        ' angelhack '=> '11111111110001001111110100111100110111111100101111010010111111000111111111110001');
$commonWordLength=21;

#Hee's the fun part.
#Now we run the main function, named decode. This function takes two inputs.
#The first input is the message. The second input is the dictionary list.
#The function returns and prints the final answer.
$answer=decode($ahMsg, \%ahDictionary);
print("\n \n \n FINAL ANSWER: \n $answer \n");


sub decode() {
	#Pick off the two inputs
	$secretMsg=$_[0];
	%codeDictionary=%{$_[1]};

	#Do the fun stuff
	checkCommonWords();
	checkForSpaces();
	checkLetters(\@letterF);
	undoErrors();
	checkLetters(\@letterF2);
	return $secretMsg;
}



sub checkCommonWords() {

	print("Now checking common Words... \n");
	#This function checks for the words in the commonWordHash list.
	#This function uses hashes, so I don't know the order of the checking.
	
	@commonStrings=values %commonWordHash;
	@commonWordText=keys %commonWordHash;
	$commonWordLength=keys %commonWordHash;
	for($ii=0;$ii<$commonWordLength;$ii=$ii+1)
	{
	        $tempText=$commonWordText[$ii];
	        $tempString=$commonStrings[$ii];

		#Here we're using a regex. The s stands for substitute.
		#The modifier g at the end of the next line means replace all
	        $secretMsg=~ s/$tempString/$tempText/g;
	}
        #print the message and see if we're done...
        print("Message so far = $secretMsg \n");
}


sub checkForSpaces()
{
	print("Now checking for spaces ...\n");
	#Here we check for spaces and sets of three spaces.
	$aString="11111111110001";
	$aText=" ";
	#Here we use that regex again
	$secretMsg=~ s/$aString/$aText/g;
	#Replace three spaces in a row with space yab space.
	#Solutions will not be unique.
	$threeSpace="   ";
	$threeSpNew=" yab ";
	$secretMsg=~ s/$threeSpace/$threeSpNew/g;
	print("Message so far = $secretMsg \n");
}


sub checkLetters()
{
	print("Now checking for individual letters, starting with most common\n");
	@letterFreq=@{$_[0]};
	#@letterFreq=@letterF;
	$dictLength=keys %codeDictionary;
	#Let's start with the most common letters...
	for($kk=0;$kk<$dictLength+1;$kk=$kk+1)
	{
		$cLetter=$letterFreq[$kk];
		$cString=$codeDictionary{$cLetter};
		$secretMsg=~s/$cString/$cLetter/g;
	}
	print("Message so far = $secretMsg \n");

}


sub undoErrors()
{
	print("Undoing errors\n");
	#This function looks for 1's in the message. If you find any, you 
	#know there is an error. So, it undoes the substitution.
	
	#Here we look for a 1 followed by two letters, and we undo it.
	#Note, these loops purposely start at 1, not 0, to avoid spaces.
	for($pp=1;$pp<$dictLength;$pp=$pp+1)
	{
		$pLetter=$letterFreq[$pp];
		$pString=$codeDictionary{$pLetter};
		for($qq=1;$qq<$dictLength;$qq=$qq+1)
		{
			#Look for 1ppqq and undo it
			#I really should look for 0ppqq too... but I don't need to
			#for this message
			$qLetter=$letterFreq[$qq];
			$qString=$codeDictionary{$qLetter};
			$triLetter="1$qLetter$pLetter";
			$triString="1$qString$pString";
			#		print("Replacing $triLetter with $triString \n");
			$secretMsg=~s/$triLetter/$triString/g;
			}
	}
	#Here we look for a 1 followed by 1 letter, and we undo it.
	for($gg=0;$gg<$dictLength;$gg=$gg+1)
	{
		$gLetter=$letterFreq[$gg];
		$gString=$codeDictionary{$gLetter};
		$hLetter="1$gLetter";
		$hString="1$gString";
		$secretMsg=~s/$hLetter/$hString/g;
	}
	
	print("Message so far = $secretMsg \n");
}
