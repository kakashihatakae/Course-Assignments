#!/usr/local/bin/python3
#
# hide.py : a simple friend-hider
#
# Submitted by : username : sbhujbal  name: Shreyas
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

def check_amp_F_in_forward_list(board_list):
    l_temp = []
    for element in board_list:
        if element in 'F&':
            l_temp.append(element)
            if l_temp[0] == 'F':
                return False
                break
            if l_temp[0] == '&':
                break

def check_amp_F_in_backward_list(board_list):
    l_temp = []
    for i in range(len(board_list), -1, -1):
        if(board_list[i] in 'F&'):
            l_temp.append(board_list[i])
            if l_temp[0] == 'F':
                return False
                break
            if l_temp[0] == '&':
                break

def check_visibility(row,col,board):
    #dist between 2 F should be greater that distance between & and Fss
    list = []
    if board[row][col] == '.':
        if col > 0:
            for col_number in range((col-1),-1, -1):
                # print(col_number)
                if(board[row][col_number] in 'F&'):
                    if board[row][col_number] == 'F':
                        # print("1")
                        return False
                    if board[row][col_number] == '&':
                        break

        for element in board[row][(col+1):]:
            if(element in 'F&'):
                if element == 'F':
                    # print("2")
                    return False
                if element == '&':
                    break

        board_column_list = []
        for temp_row in board:
            board_column_list.append(temp_row[col])
        # print(board_column_list)

        if row > 0:
            for row_number in range(row-1, -1, -1):
                if(board[row_number][col] in 'F&'):
                    if board[row_number][col] == 'F':
                        # print("3")
                        return False
                    if board[row_number][col] == '&':
                        break

        for element in board_column_list[(row+1):]:
            if(element in 'F&'):
                if element == 'F':
                    # print("4")
                    return False
                if element == '&':
                    break

        return True
    return False


# Return a string with the board rendered in a human-friendly format
def printable_board(board):
    return "\n".join([ "".join(row) for row in board])

# Add a friend to the board at the given position, and return a new board (doesn't change original)
def add_friend(board, row, col):
    return board[0:row] + [board[row][0:col] + ['F',] + board[row][col+1:]] + board[row+1:]

# Get list of successors of given board state
def successors(board):
    return [ add_friend(board, r, c) for r in range(0, len(board)) for c in range(0,len(board[0])) if check_visibility(r,c,board) ]

# check if board is a goal state
def is_goal(board):
    # print("---------------------------------")
    # print(count_friends(board))
    # print("---------------------------------")
    return count_friends(board) == K 

def print_fringe(fringe):
    for i in fringe:
        for j in i:
            print(j)
        print('\n')

# Solve n-rooks!
def solve(initial_board):
    fringe = [initial_board]
    visited = []
    # print(fringe)
    while len(fringe) > 0:
        for s in successors( fringe.pop() ):
            if s not in visited:
                if is_goal(s):
                    return(s)
                fringe.append(s)
                visited.append(s)
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


