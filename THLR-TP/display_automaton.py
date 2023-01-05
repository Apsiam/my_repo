from graphviz import Digraph


# Display the NFA or ENFA 'automaton' and exports it to 'file'.pdf
def export_automaton(automaton, file):
    graph = Digraph(filename=file)
    graph.graph_attr['rankdir'] = 'LR'
    for state in automaton.all_states:
        node_shape = 'circle'
        if state in automaton.final_states:
            node_shape = 'doublecircle'
        graph.attr('node', shape=node_shape, style='filled', \
                   fillcolor='white')
        graph.node(str(state))
        if state in automaton.initial_states:
            graph.node(str(state) + "_i", style="invisible")
            graph.edge(str(state) + "_i", str(state))
    for state in automaton.all_states:
        for letter in automaton.alphabet:
            for next_state in automaton.next_states[(state, letter)]:
                if letter == "":
                    # letter = "ε"
                    edge_colour = 'gray'
                    edge_label = " "
                else:
                    edge_colour = 'black'
                    edge_label = letter
                graph.edge(str(state), str(next_state), label=edge_label,
                           color=edge_colour)
    graph.render()
