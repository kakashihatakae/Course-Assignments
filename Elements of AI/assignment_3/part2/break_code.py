#!/usr/local/bin/python3
# CSCI B551 Fall 2019
#
# Authors: Shreyas Bhujbal
#
# based on skeleton code by D. Crandall, 11/2019
#
# ./break_code.py : attack encryption
#


import random
import math
import copy 
import sys
import encode
from random import randint
import math
import numpy as np

def init_table():
    list_alpha = []
    table = {}
    
    for i in range(97, 123):
        list_alpha.append(chr(i))
    # print(list_alpha)
    
    # random.seed(10)
    # random.shuffle(list_alpha)
    
    # print(list_alpha)
    
    for i in range(97, 123):
        character = chr(i)
        table[character] = list_alpha[i-97]
    print(table)
    print('init_done')
    return table

def cal_W0(corp, letter):
    sample = 0
    start_letter = 0
    for word in corp:
        sample = sample+1
        if word[0] == letter:
            start_letter = start_letter + 1
    print('W0: ', letter, ' ', start_letter/sample)
    return start_letter/sample

def cal_Wi(corp, letter1, letter2):
    #p(letter1 | letter2 )
    numerator = 0
    denominator = 0
    for word in corp:
        for i in range(len(word) - 1):
            if word[i] == letter1 and word[i+1] == letter2:
                numerator = numerator + 1
                # print(numerator)
            if word[i] == letter1 :
                denominator = denominator + 1
                # print(denominator)
    if denominator == 0:
        print('Wi: letter1: ', letter1, 'letter2: ', letter2, ' ', denominator)
        return 0

    print('Wi: letter1: ', letter1, 'letter2: ', letter2, ' ', numerator/denominator)
    return numerator/denominator

def cal_all_probs(corpus):
    probs = {}
    print('calculating probability')
    for i in range(97, 123):
        for j in range(97, 123):
            probs[chr(i) + chr(j)] = cal_Wi(corpus, chr(i), chr(j))
    for k in range(97,123):
        probs[chr(k)] = cal_W0(corpus, chr(k))
    return probs
        
def change_config(table, rearrange_tab):
    
    flag = random.randint(0,1) 
    temp = ''
    tmp = {}
    if flag:
        ind = random.randint(0,2)
        tmp = rearrange_tab[ind]
        rearrange_tab[ind] = rearrange_tab[ind+1]
        rearrange_tab[ind+1] = tmp
    else:
        rn = random.randint(97, 121)
        temp = table[chr(rn)]
        table[chr(rn)] = table[chr(rn+1)]
        table[chr(rn+1)] = temp
    return [table, rearrange_tab]

# put your code here!
def break_code(string, corpus):
    # use encode function, change either table or rearrange list
    
    rearrange_tab = [0,1,2,3]
    random.shuffle(rearrange_tab)
    table = init_table()    
    counter = 0
    flag = 0
    text = string.split()
    corp = corpus.split()
    p = 0
    x = 0
    p_prev = float('-Inf')
    table_prev = {}
    rearrange_tab_prev = []
    probs = cal_all_probs(corp)
    break_flag = 0
    
    while(counter < 100000):
        counter = counter + 1
        # print(counter)
        new_text = encode.encode(string, table, rearrange_tab)
        
        # if p>math.log10(1+0.5) and p != float('Inf'):
        #     return new_text
        
        if(counter > 79998):
            return new_text
        
        new_text = new_text.split()
        p = 0
        for word in new_text:
            if len(word) == 1:
                # print(probs[word])
                if probs[word]:
                    x = probs[word]
                    p = p + math.log10(x)
                # else:
                #     p = p+0
                #     table, rearrange_tab = change_config(table, rearrange_tab)
                #     break
                    
            else:
                for i in range(len(word)):
                    if(not i):
                        # print(probs[word[0]])
                        if probs[word[0]]:
                            x = probs[word[0]]
                            p = p + math.log10(x)

                        # else:
                        #     p = p+0
                            # break_flag = 1
                            # break
                    
                    else:
                        # print(probs[word[i-1]+word[i]])
                        if probs[word[i-1]+word[i]]:
                            x = probs[word[i-1]+word[i]]
                            p = p + math.log10(1+x)
                        # else:
                        #     p = p + 0
                            # break_flag = 1
                        #     break

            # if p == float('Inf') or break_flag == 1:
            #     table, rearrange_tab = change_config(table, rearrange_tab)
            #     break_flag = 0
            #     # print('==================================')
            #     # print('break')
            #     # print('==================================')
            #     break



        if p > p_prev:
            print('---------')
            print('probab: ', p, 'pprev: ', p_prev, 'counter ', counter)
            print('---------')

            print('******** Improved ************')
            table_prev = table
            rearrange_tab_prev = rearrange_tab
            p_prev = p
            table, rearrange_tab = change_config(table_prev, rearrange_tab_prev)

        
        # if p < p_prev:
        #     print('---------')
        #     print('probab: ', p, 'pprev: ', p_prev)
        #     print('---------')
        #     sc = np.exp(p_prev - p)
        #     print('******** Not Improved ************')
        #     table = table_prev
        #     rearrange_tab = rearrange_tab_prev
        #     p = p_prev
        #     table, rearrange_tab = change_config(table, rearrange_tab)
        
        sc = np.exp(p - p_prev)
        prob = sc if sc <= 1 else 1
        print(sc)
        if prob > random.uniform(0,1):
            print(p)
            table_prev = table
            rearrange_tab_prev = rearrange_tab
            p_prev = p    
        table, rearrange_tab = change_config(table_prev, rearrange_tab_prev)




if __name__== "__main__":
    if(len(sys.argv) != 4):
        raise Exception("usage: ./break_code.py coded-file corpus output-file")

    encoded = encode.read_clean_file(sys.argv[1])
    corpus = encode.read_clean_file(sys.argv[2])
    decoded = break_code(encoded, corpus)

    with open(sys.argv[3], "w") as file:
        print(decoded, file=file)

