# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util
import sys
from util import manhattanDistance

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]


def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print "Start:", problem.getStartState()
    print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    print "Start's successors:", problem.getSuccessors(problem.getStartState())
    """
    search_stack = util.Stack()
    successors = problem.getSuccessors(problem.getStartState())
    for ea in successors:
        search_stack.push(ea)
    find_goal = False
    path_actions = []
    visited_pos = set()
    visited_pos.add(problem.getStartState())
    while not search_stack.isEmpty() and not find_goal:
        choice = search_stack.pop()
        if not problem.isGoalState(choice[0]):
            if not choice[0] in visited_pos:
                visited_pos.add(choice[0])
                path_actions.append(choice)

            choice_successors = filter(lambda v: v[0] not in visited_pos, problem.getSuccessors(choice[0]))
            if not len(choice_successors):
                path_actions.pop(-1)
                if path_actions:
                    search_stack.push(path_actions[-1])
            else:
                for ea in choice_successors:
                    search_stack.push(ea)
        else:
            path_actions.append(choice)
            visited_pos.add(choice[0])
            find_goal = True
    return [ea[1] for ea in path_actions]

def breadthFirstSearch(problem):
    """Search the shallowest nodes in the search tree first."""
    search_queue = util.Queue()
    visited_pos = set()
    search_queue.push((problem.getStartState(), []))
    while not search_queue.isEmpty():
        (current_pos, path_actions) = search_queue.pop()
        if problem.isGoalState(current_pos):
            return path_actions
        if not visited_pos.__contains__(current_pos):
            visited_pos.add(current_pos)
            choice_successors = filter(lambda v: v[0] not in visited_pos, problem.getSuccessors(current_pos))
            for ea in choice_successors:
                search_queue.push((ea[0], (path_actions + [ea[1]])))
    print "*** Target not found!"
    sys.exit(1)

def uniformCostSearch(problem):
    search_queue = util.PriorityQueue()
    visited_pos = set()
    search_queue.push((problem.getStartState(), [], 0),0)
    while not search_queue.isEmpty():
        (current_pos, path_actions, path_cost) = search_queue.pop()
        if problem.isGoalState(current_pos):
            return path_actions
        if not visited_pos.__contains__(current_pos):
            visited_pos.add(current_pos)
            choice_successors = filter(lambda v: v[0] not in visited_pos, problem.getSuccessors(current_pos))
            for ea in choice_successors:
                search_queue.push((ea[0], (path_actions + [ea[1]]), (path_cost + ea[2])),(path_cost + ea[2]))
    print "*** Target not found!"
    sys.exit(1)

def greedySearch(problem):
    search_queue = util.PriorityQueue()
    visited_pos = set()
    search_queue.push((problem.getStartState(), []), manhattanDistance(problem.getStartState(),target_pos))
    while not search_queue.isEmpty():
        (current_pos, path_actions) = search_queue.pop()
        if problem.isGoalState(current_pos):
            return path_actions
        if not visited_pos.__contains__(current_pos):
            visited_pos.add(current_pos)
            choice_successors = filter(lambda v: v[0] not in visited_pos, problem.getSuccessors(current_pos))
            for ea in choice_successors:
                search_queue.push((ea[0], (path_actions + [ea[1]])), manhattanDistance(ea[0],target_pos))
    print "*** Target not found!"
    sys.exit(1)

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    search_queue = util.PriorityQueue()
    visited_pos = set()
    search_queue.push((problem.getStartState(), [], 0), manhattanDistance(problem.getStartState(), target_pos))
    while not search_queue.isEmpty():
        (current_pos, path_actions, path_cost) = search_queue.pop()
        if problem.isGoalState(current_pos):
            return path_actions
        if not visited_pos.__contains__(current_pos):
            visited_pos.add(current_pos)
            choice_successors = filter(lambda v: v[0] not in visited_pos, problem.getSuccessors(current_pos))
            for ea in choice_successors:
                search_queue.push((ea[0], (path_actions + [ea[1]]), (path_cost + ea[2])), (path_cost + ea[2] + manhattanDistance(ea[0],target_pos)))
    print "*** Target not found!"
    sys.exit(1)

# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
gs = greedySearch
target_pos = (1,1)