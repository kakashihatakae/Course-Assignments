#!/usr/local/bin/python3
# CSCI B551 Fall 2019
#
# Authors: PLEASE PUT YOUR NAMES AND USERIDS HERE
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

def init_table():
    list_alpha = []
    table = {}
    
    for i in range(97, 123):
        list_alpha.append(chr(i))
    # print(list_alpha)
    random.seed(10)
    random.shuffle(list_alpha)
    
    # print(list_alpha)
    
    for i in range(97, 123):
        character = chr(i)
        table[character] = list_alpha[i-97]
    # print(table)
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

#check this
def cal_Wi(corp, letter1, letter2):
    #p(letter2 | letter1 )
    numerator = 0
    denominator = 0
    for word in corp:
        for i in range(len(word) - 1):
            if word[i] == letter1 and word[i+1] == letter2:
                numerator = numerator + 1
            
            if word[i] == letter1 :
                denominator = denominator + 1
    print('Wi: letter1: ', letter1, 'letter2: ', letter2, ' ', numerator/denominator)
    return numerator/denominator


def decode(text, table):
    empty_list = []
    for word in text:
        empty_str = ''
        for letter in word:
            empty_str = empty_str + table[letter]
        empty_list.append(empty_str)
    
    return empty_list

def rearrange(table):
    ran = randint.random(97, 123)
    temp = table[chr(ran+1)]
    table[chr(ran+1)] = table[chr(ran)]
    table[chr(ran)] = temp
    return table    

# put your code here!
def break_code(string, corpus):
    table = init_table()
    
    text = string.split()
    corp = corpus.split()
    p = 1
    new_text = decode(text, table)
    
    #add a break if the p is zero
    while(1):
        for word in new_text:
            if len(word) == 1:
                p = p*cal_W0(corp, word)
            else:
                for i in range(len(word)):
                    if(not i):
                        p = p*cal_W0(corp, word[0])
                    else:
                        p = p*cal_Wi(corp, word[i-1], word[i])
                    print("Probability: ", p)
            if p == 0:
                table = rearrange(table)
                break
        if p > 0.5
            return p


if __name__== "__main__":
    if(len(sys.argv) != 4):
        raise Exception("usage: ./break_code.py coded-file corpus output-file")

    encoded = encode.read_clean_file(sys.argv[1])
    corpus = encode.read_clean_file(sys.argv[2])
    decoded = break_code(encoded, corpus)

    with open(sys.argv[3], "w") as file:
        print(decoded, file=file)

