from graphviz import Digraph
from display_automaton import export_automaton


# A tree-based representation of regular expresssions
class RegEx:

    def __init__(self, symbol, children):
        self.symbol = symbol
        self.children = children

    def to_string(self):
        if self.symbol == "*":
            return "(" + self.children[0].to_string() + ")*"
        elif self.symbol == "+":
            return self.children[0].to_string() + "+" \
                + self.children[1].to_string()
        elif self.symbol == ".":
            return self.children[0].to_string() + self.children[1].to_string()
        else:
            return self.symbol

    # Question 4
    # Output an epsilon-NFA equivalent to the regular expression
    def to_enfa(self): 
        A = ENFA([0,1],[0],[1], [], [])
        A.convert_reg_ex(0,1,self)
        return A


# Non-deterministic finite automata with epsilon transitions
class ENFA:

    def __init__(self, all_states, initial_states, final_states,
                 alphabet, edges):
        # States: a set of integers
        self.all_states = set(all_states)
        # The alphabet: a set of strings
        # "" stands for epsilon
        self.alphabet = set(alphabet)
        self.alphabet.add("")
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
    # Add a new state to the automaton
    def new_state(self):
        newState = 0
        new = False
        while (newState in self.all_states):
            newState += 1
        self.all_states.add(newState)

        for letter in self.alphabet:
            self.next_states[(newState, letter)] = set()
        return newState


    # Question 2
    # Add a new letter 'letter' to the automaton
    def new_letter(self, letter):
        self.alphabet.add(letter)
        for state in self.all_states:
	        self.next_states[(state,letter)] = set()
        return

    # Question 3
    # Insert the automaton matched to the regular expression 'reg_ex'
    # between the two states 'origin' and 'destination' according to
    # Thompson's algorithm
    def convert_reg_ex(self, origin, destination, reg_ex):
        if (reg_ex.symbol in self.alphabet):
            self.next_states[(origin,reg_ex.symbol)].add(destination)
            return
        A = self.new_state()
        B = self.new_state()
        if (reg_ex.symbol == "."):
            self.next_states[(A,"")].add(B)
            self.convert_reg_ex(origin,A,reg_ex.children[0])
            self.convert_reg_ex(B,destination,reg_ex.children[1])
        elif (reg_ex.symbol == "+"):
            C = self.new_state()
            D = self.new_state()
            self.next_states[(origin,"")].add(A)
            self.next_states[(origin,"")].add(C)
            self.next_states[(B,"")].add(destination)
            self.next_states[(D,"")].add(destination)
            self.convert_reg_ex(A,B,reg_ex.children[0])
            self.convert_reg_ex(C,D,reg_ex.children[1])
        elif (reg_ex.symbol == "*"):
            self.next_states[(origin,"")].add(A)
            self.next_states[(origin,"")].add(destination)
            self.next_states[(B,"")].add(destination)
            self.next_states[(B,"")].add(A)
            self.convert_reg_ex(A,B,reg_ex.children[0])
        else:
            self.new_letter(self, reg_ex.symbol)
            self.convert_reg_ex(origin, destination, reg_ex)
        return
            
			 
			 

    # Question 5
    # Returns the epsilon forward closure of a state 'origin'
    def epsilon_reachable(self, origin):
        cloture = [origin]
        statetocheck = [origin]
        while statetocheck > 0:
            newState = []
            for state in statetocheck:
                for destination in self.next_states[(state,"")]:
                    cloture.append(destination)
                    newState.append(destination)
            statetocheck = newState
        return cloture

    # Question 6
    # Returns a NFA equivalent to the epsilon NFA by performing a backward
    # removal of epsilon transitions
    def to_nfa(self):
        pass
    
#A = ENFA([0, 1, 2], [0], [1], ["a", "b"], [(0, "a", 1), (0, "", 1),(1, "b", 2), (2, "", 0)])
#A.new_state()
#A.new_letter("hs")
#testconcat = RegEx(".", [RegEx("a",[]),RegEx("b",[])])
#A.convert_reg_ex(0,1,testconcat)
#print(A.alphabet)
#A = ENFA([0, 1], [0], [1], ["a", "b"], [])
test = RegEx("+", [RegEx("a",[]),RegEx("b",[])])
test2 = RegEx("*",test)
A = test2.to_enfa()
print(A.epsilon_reachable(0))
#A.convert_reg_ex(0, 1, test2)
export_automaton(A, "A")

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
