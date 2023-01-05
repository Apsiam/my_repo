from graphviz import Digraph
from display_automaton import export_automaton


# Non-deterministic finite automaton
class NFA:

    def __init__(self, all_states, initial_states, final_states,
                 alphabet, edges):
        # States: a set of integers
        self.all_states = set(all_states)
        # The alphabet: a set of strings
        # "" stands for epsilon
        self.alphabet = set(alphabet)
        if "" in self.alphabet:
            self.alphabet.remove("")
        # Initial and final states: two sets of integers
        self.initial_states = set(initial_states).intersection(self.all_states)
        self.final_states = set(final_states).intersection(self.all_states)
        # There must be an initial state; if there isn't, an initial state 0
        # is added
        if not self.initial_states:
            self.initial_states.add(0)
            self.all_states.add(0)
        # Edges: a dictionnary (origin, letter): set of destinations
        self.next_states = {(state, letter): set()
                            for state in self.all_states
                            for letter in self.alphabet}
        for edge in set(edges):
            if (edge[0] in self.all_states) and (edge[2] in self.all_states) \
                    and (edge[1] in self.alphabet):
                self.next_states[(edge[0], edge[1])].add(edge[2])

    # Question 1
    # Returns the set of states reachable from the state 'origin'
    # by reading the input 'word'
    def reachable_states(self, origin, word):
        pass

    # Question 2
    # Determines if the automaton accepts the word 'word'
    def accepts(self, word):
        pass

    # Question 3
    # Determines if the state 'target' is reachable from the state 'origin'
    def accessible(self, origin, target):
        pass

    # Question 4
    # Determines if the state 'state' is useful
    def is_useful(self, state):
        pass

    # Question 5
    # Remove the state 'state' from the automaton
    def remove_state(self, state):
        pass

    # Question 6
    # Prune the automaton
    def prune(self):
        pass