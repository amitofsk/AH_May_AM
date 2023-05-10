/*This program was written in Java by Andy Mitofsky.
 * This is my solution for the May 10 Anglehack contest.
 * The important decision to make is which worker to drop. The order of pairing up the remaining workers
 * is not an important decision, as long as you pick neighbors in a sorted list. I'll use java's built in
 * array sort function, not write my own here. I'm not sure you'll get the best answer with this 
 * assumption, but I think you will. I spot checked the answer using subsets and some code in 
 * scilab, so I think it works. That code is attached too in case you want to see it.The scilab
 * code isn't really part of my solution. It was just for checking my answer, and it isn't really 
 * complete. This file is the solution.
 * The answer is 475.
 */ 
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Comparator;
class Solution_10_5_2023 {
	public static void main(String[] args) {
		System.out.println("Hello");
		//Here are the starting values
		ArrayList<Integer> workersOriginal=new ArrayList<Integer>(Arrays.asList(1, 3, 54, 712, 52, 904, 113, 12, 135, 32, 31, 56, 23, 79, 611, 123, 677, 232, 997, 101, 111,123, 2, 7, 24, 57, 99, 45, 666, 42, 104, 129, 554, 335, 876, 35, 15, 93, 13));
		ArrayList<Integer> workers = new ArrayList<Integer>();
		int bestScore=1000000; //low score is good, so initially set the starting score very high, clean me later
		int score=0;
		int bestWorkerLocationCut=0;
		int listlen=workersOriginal.size();
		//sort the workers
		workersOriginal.sort(Comparator.naturalOrder());
		//Uncomment the next line to see the sorted list.
		//System.out.println(workersOriginal);
	
		for(int ii=0;ii<listlen;ii++) 
		{
			//reject the ii'th worker.
			workers=(ArrayList)workersOriginal.clone();  
			workers.remove(ii);
			score =0;
			//Calculate the score... Here we assume workers are paired up, from 
			//the sorted list [0,1], [2,3], [4,5],...
			for (int jj=0;jj<(listlen-1);jj+=2)
			{
				score=score+((workers.get(jj+1))-(workers.get(jj)));
			//	System.out.println("Next Pair" + workers.get(jj)+"  "+workers.get(jj+1));

			}
			if(score<bestScore)
			{
				//we found the best worker to cut so far
				bestScore=score;
				bestWorkerLocationCut=ii;
			}
		}
		//Uncomment this section to display the worker pairs
		/*
		workers=(ArrayList)workersOriginal.clone();
		workers.remove(bestWorkerLocationCut);
		for(int kk=0;kk<(listlen-1);kk+=2)
		{
			System.out.println("Next Pair" + workers.get(kk)+"  "+workers.get(kk+1));
			
		}
		*/
		System.out.println("Best score = "+bestScore);
		System.out.println("Best worker to cut = "+workersOriginal.get(bestWorkerLocationCut));
	}
}
