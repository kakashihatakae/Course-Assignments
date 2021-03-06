#!/usr/local/bin/python3
#
# hide.py : a simple friend-hider
#
# Submitted by : [PUT YOUR NAME AND USERNAME HERE]
#
# Based on skeleton code by D. Crandall and Z. Kachwala, 2019
#
# The problem to be solved is this:
# Given a campus map, find a placement of F friends so that no two can find one another.
#

import sys

# Parse the map from a given filename
def parse_map(filename):
	with open(filename, "r") as f:
		return [[char for char in line] for line in f.read().split("\n")]

# Count total # of friends on board
def count_friends(board):
    return sum([ row.count('F') for row in board ] )

def check_visibility(row,col,board):
    #dist between 2 F should be greater that distance between & and Fss
    if board[row][col] == '.':
        after_element = board[row][:(col+1)]
        if col > 0:
            before_element = board[row][:col]
            for col_number in range(len(board[0]),-1, -1):
                if(board[row][col_number] == 'F'):
                    return False
        for element in after_element:
            if(element == 'F'):
                return False

        board_column_list = board[0:][col]
        if row > 0:
            for row_number in range(len(board_column_list),-1, -1):
                if(board_column_list[row_number] == 'F'):
                    return False

        for element in board_column_list[(row+1):]:
            if(element == 'F'):
                return False

        return True


# Return a string with the board rendered in a human-friendly format
def printable_board(board):
    return "\n".join([ "".join(row) for row in board])

# Add a friend to the board at the given position, and return a new board (doesn't change original)
def add_friend(board, row, col):
    return board[0:row] + [board[row][0:col] + ['F',] + board[row][col+1:]] + board[row+1:]

# Get list of successors of given board state
def successors(board):
    return [ add_friend(board, r, c) for r in range(0, len(board)) for c in range(0,len(board[0])) if board[r][c] == '.' ]

# check if board is a goal state
def is_goal(board):
    return count_friends(board) == K 

# Solve n-rooks!
def solve(initial_board):
    fringe = [initial_board]
    print(fringe)
    while len(fringe) > 0:
        for s in successors( fringe.pop(0) ):
            print(fringe)
            print('\n')
            if is_goal(s):
                return(s)
            fringe.append(s)
    return False

# Main Function
if __name__ == "__main__":
    IUB_map=parse_map(sys.argv[1])

    # This is K, the number of friends
    K = int(sys.argv[2])
    print ("Starting from initial board:\n" + printable_board(IUB_map) + "\n\nLooking for solution...\n")
    solution = solve(IUB_map)
    print ("Here's what we found:")
    print (printable_board(solution) if solution else "None")


