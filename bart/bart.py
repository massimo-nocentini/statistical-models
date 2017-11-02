
from collections import namedtuple



node = namedtuple('node', 
            ['left', 'right', 'variable', 'split_value', 'population'])

crumb = namedtuple('crumb',
            ['direction', 'other_branch', 'variable', 'split_value', 'population'])


def go_left(tree, crumbs):
    c = crumb('L', tree.right, tree.variable, tree.split_value, tree.population)
    return tree.left, [c] + crumbs

def go_right(tree, crumbs):
    c = crumb('R', tree.left, tree.variable, tree.split_value, tree.population)
    return tree.right, [c] + crumbs

def go_up(tree, crumbs):
    c, *cs = crumbs
    n = (node(tree, c.other_branch, c.variable, c.split_value, c.population) 
         if c.direction == 'L' 
         else node(c.other_branch, tree, c.variable, c.split_value, c.population))
    return n, cs

def go_root(tree, crumbs):

    if crumbs:
        t, cs = go_up(tree, crumbs)
        return go_root(t, cs)
    else:
        return tree, []
        

def grow(variable, split_value):

    def G(tree, crumbs):

        if not tree.population:
            return tree, crumbs

        if tree.left or tree.right:
            raise ValueError('Subtrees not both empty for growing')

        left_population, right_population = split_population(tree.population, variable, split_value)
        l = node(None, None, None, None, left_population)
        r = node(None, None, None, None, right_population)
        t = tree._replace(  left=l, 
                            right=r, 
                            variable=variable, 
                            split_value=split_value) 
        return t, crumbs
    
    return G

def split_population(population, variable, split_value):
    
    left_population, right_population = [], []
    for item in population:
        recipient = left_population if item[variable] < split_value else right_population
        recipient.append(item)

    return left_population, right_population

def prune(tree, crumbs):
    return node(None, None, None, None, tree.population), crumbs 

def change(variable, split_value):

    def update(tree, population):

        if not tree.variable:
            return node(None, None, None, None, population)

        left_population, right_population = split_population(
            population, tree.variable, tree.split_value)
        l = update(tree.left, left_population)
        r = update(tree.right, right_population)
        t = tree._replace(left=l, right=r, population=population)

        return t

    def C(tree, crumbs):
        t = tree._replace(variable=variable, split_value=split_value)
        return update(t, t.population), crumbs

    return C

def do(tree, moves):
    t, cs = tree, []
    for m in moves:
        t, cs = m(t, cs)

    r, _ = go_root(t, cs)

    return r

# ________________________________________________________________________

population = [
    {'age':40, 'height':187.5, 'weight':80},
    {'age':50, 'height':197.5, 'weight':70},
    {'age':60, 'height':207.5, 'weight':95},
]

empty_tree = node(None, None, None, None, population)

moves = [
    grow('height', 200),
    go_left,
    grow('weight', 85),
    go_up,
    go_right,
    grow('age', 75),
    go_right,
    grow('missing', None),
]

assert (do(empty_tree, moves) == 
        node(
            left=node(
                left=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                                {'age': 50, 'height': 197.5, 'weight': 70}]), 
                right=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[]), 
                variable='weight', 
                split_value=85, 
                population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                            {'age': 50, 'height': 197.5, 'weight': 70}]), 
            right=node(
                left=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[{'age': 60, 'height': 207.5, 'weight': 95}]), 
                right=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[]), 
                variable='age', 
                split_value=75, 
                population=[{'age': 60, 'height': 207.5, 'weight': 95}]), 
            variable='height', 
            split_value=200, 
            population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                        {'age': 50, 'height': 197.5, 'weight': 70}, 
                        {'age': 60, 'height': 207.5, 'weight': 95}])
        )

moves_with_pruning = moves + [
    go_root,
    go_left,
    prune,
]

assert (do(empty_tree, moves_with_pruning) == 
        node(
            left=node(
                left=None, 
                right=None, 
                variable=None, 
                split_value=None, 
                population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                            {'age': 50, 'height': 197.5, 'weight': 70}]), 
            right=node(
                left=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[{'age': 60, 'height': 207.5, 'weight': 95}]), 
                right=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[]), 
                variable='age', 
                split_value=75, 
                population=[{'age': 60, 'height': 207.5, 'weight': 95}]), 
            variable='height', 
            split_value=200, 
            population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                        {'age': 50, 'height': 197.5, 'weight': 70}, 
                        {'age': 60, 'height': 207.5, 'weight': 95}]))

moves_with_change = moves_with_pruning + [
    go_up,
    change('weight', 71),
]

assert (do(empty_tree, moves_with_change) ==
        node(
            left=node(
                left=None, 
                right=None, 
                variable=None, 
                split_value=None, 
                population=[{'age': 50, 'height': 197.5, 'weight': 70}]), 
            right=node(
                left=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                                {'age': 60, 'height': 207.5, 'weight': 95}]), 
                right=node(
                    left=None, 
                    right=None, 
                    variable=None, 
                    split_value=None, 
                    population=[]), 
                variable='age', 
                split_value=75, 
                population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                            {'age': 60, 'height': 207.5, 'weight': 95}]), 
            variable='weight', 
            split_value=71, 
            population=[{'age': 40, 'height': 187.5, 'weight': 80}, 
                        {'age': 50, 'height': 197.5, 'weight': 70}, 
                        {'age': 60, 'height': 207.5, 'weight': 95}]))
