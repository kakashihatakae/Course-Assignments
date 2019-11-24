#!/usr/local/bin/python3
#
# find_luddy.py : a simple maze solver
#
# Submitted by : Shreyas Bhujbal    username :- sbhujbal
#
# Based on skeleton code by Z. Kachwala, 2019
#

import sys
import json

# Parse the map from a given filename
def parse_map(filename):
	with open(filename, "r") as f:
		return [[char for char in line] for line in f.read().split("\n")]

# Check if a row,col index pair is on the map
def valid_index(pos, n, m):
	return 0 <= pos[0] < n  and 0 <= pos[1] < m

# Find the possible moves from position (row, col)
def moves(map, row, col):
	#added a third attribute to the moves tuple. It signifies the direction taken.
	moves=((row+1,col,'S'), (row-1,col,'N'), (row,col-1,'W'), (row,col+1,'E'))

	# Return only moves that are within the board and legal (i.e. on the sidewalk ".")
	return [ move for move in moves if valid_index(move, len(map), len(map[0])) and (map[move[0]][move[1]] in ".@" ) ]

# Perform search on the map
def search1(IUB_map):
	# Find my start position
	you_loc=[(row_i,col_i) for col_i in range(len(IUB_map[0])) for row_i in range(len(IUB_map)) if IUB_map[row_i][col_i]=="#"][0]
	fringe=[(you_loc ,0, '')]
	while fringe:
		(curr_move, curr_dist, curr_direction_string)=fringe.pop(0) #this was a stack
		for move in moves(IUB_map, curr_move[0],curr_move[1]): #
			if IUB_map[move[0]][move[1]]=="@":
				#return the updated distance and the direction string when one of the children reach the goal state
				return [curr_dist+1,curr_direction_string+move[2]] 
			else:
				#append current state with updated direction string
				fringe.append((move, curr_dist + 1, curr_direction_string+move[2])) 
				# print(fringe)
				# print(curr_dist, len(IUB_map)*len(IUB_map[0]))
			# print(fringe)
			if curr_dist > len(IUB_map)*len(IUB_map[0]):
				return 'Inf'
	return 'Inf'
#if queue runs out, there is no solution

# Main Function
if __name__ == "__main__":
	IUB_map=parse_map(sys.argv[1])
	print("Shhhh... quiet while I navigate!")
	solution = search1(IUB_map)
	print("Here's the solution I found:")
	print(solution)

