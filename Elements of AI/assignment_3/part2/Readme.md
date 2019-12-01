This particular assignment required us to calculate the overall probability of document that was decrypted using a
table and a rearrangement table. 

Functions:

1. def init_table()
This function randomly maps all the letters to its keys. Is used for initialising a decryption table randomly. Basically It creates a list of numbers from 97-122(ascii values for alphabets), shuffles them and then converts them to characters and maps this shuffled list to a list of ordered alphabet list in a dictionary and returns this dictionary. 

2. cal_W0(corp, letter)
This function calculates the initial probability from the given corpus of a particular letter. It basically calculates
the probability of a word starting with a particular letter. The numerator counts the number of words starting with a 
particular letter, on the other hand denominator counts the total number of words in the corpus. The function basicaly
returns numerator/denominator which is the required probability.

3. cal_Wi(corp, letter1, letter2)
This function calculates the transition probabilities of two letters in a word. It basically calculates the probability of
letter2 being after letter1 given that letter1 is just before it. So basically the function calculates the numerator and
the denominator and divide the numerator by the denominator to calculate the probability. A nested for loop is used for 
the implementation. The first for loop is used to iterate over all the words in the document. The second for loop is used to
iterate over all the letter of the word.  The numerator counts all the instances of letter1 being the first letter and
letter2 being the second letter, on the other hand the denominator counts all the instances where the first letter is
letter1 irrespective of what the second letter is. This functions returns numertor/denominator. It returns a '0' if 
the denominator is zero.

4. def cal_all_probs(corpus)
it calculates all the transition and initial probabilities and stores it in a dictionary. So it calculates 26*26+26
probabilities, conditional transition probabilities of all the letters with each other and probabilities of a word 
starting with all the letters one by one. It calls the cal_wi function first to calculate all the transition probabilities
in a nested for loop. It then calls cal_W0 to calculate all the initial probabilities in a single for loop. It then returns
a dictionary conatining all the probabilities.

5. change_config(table, rearrange_tab)
Here the 'table' variable represents the decrytion table variable and rearrange_tab variable represents the rearrangement
table. It randomly generates 0 or 1 , and then it makes changes in the decryption table if its a 0 and changes the 
rearrangement table if it's a 1. The 0 or 1 value is assigned to a variable called flag. There is a random number 
generator used in making changes to both the tables. The random number  generator generates indices in the case
of the rearrangement table, and it generates the ascii values for the keys to be exchanged in the case of the decryption table. This function returns the changed table and rearranged tables. 

6. break_code(string, corpus)
This function takes string and corpus as arguments. This is the main function that works on the probability to calculate the
probability of the document. 

Approach 1.
In the first approach, I had written code to calculate the probabilities when they were needed. It was calculating
probabilities in the loop according the given decrypted corpus. This was a very time consuming ptocess and was very slow.
So I used dictionaries instead to calculate the probabilities and store them before hand. This increased the speed of the 
loop by a huge margin.
I was also breaking through the loop if I came across a zero probability and I would call functions to rearrange the tables.

Approach 2:
In this approach as mentioned earlier I precalculated the probabilities in this version and stored them in a dictionary. 
I also removed the '0 condition' basicially I was ignoring all the zero probabilities and still continuing calculating the
probabilities. I also calculated a condition at the end of calculation of the probabilities which basically stored the tables
if the probability was better than the previous iteration. Eliminating the zero condition and adding these new lines gave 
room for improvement with every iteration.


So basically this function initiallizes all the variables needed. Then it uses a while to keep track of the number of 
the number of iterations. Inside this while loop there is a for loop that iterates over every word in the decryted 
document. Another for loop is used inside this loop that calls the previously calculated probabilities stored in a dictionary. It then adds up the log of probabilites. The log function was used because the probabilities are very
low. At the end of the for loop the current probability is compared to the previous probability. If the current 
probability is better than the previous probability, then the current table and rearrangement table are stored in
different variables. If thhe current probability is less than the previous, the replacement table and the 
rearrangement table associated with the previous probability is assigned to the current replacement and rearrangement
table variables. 
