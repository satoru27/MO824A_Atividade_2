'''
Activity 2 - IP model for 2-TSP.

atividade2.py: solves 2-TSP, using Gurobi.

2-TSP: find the 2 shortest hamiltonian cycles in a complete graph.
Based on Gurobi's `tsp.py` example.

Subject:
    MC859/MO824 - Operational Research.
Authors:
    Victor Ferreira Ferrari  	 - RA 187890
    Flávio Murilo Reginato       - RA 197088
    Vitor Satoru Machi Matsumine - RA 264962

University of Campinas - UNICAMP - 2020

Last Modified: 06/10/2020
'''
import sys
import math
import random
from itertools import combinations
import gurobipy as gp
from gurobipy import GRB

# Callback - use lazy constraints to eliminate sub-tours
def subtourelim(model, where):
    if where == GRB.Callback.MIPSOL:
        
        # Do it for both tours.
        for t in range(2):
            # make a list of edges selected in the solution
            vals = model.cbGetSolution(model._vars[t])
            selected = gp.tuplelist((i, j) for i, j in model._vars[t].keys()
                                if vals[i, j] > 0.5)

            # find the shortest cycle in the selected edge list
            tour = subtour(selected)
            if len(tour) < n:
                # add subtour elimination constr. for every pair of cities in tour
                model.cbLazy(gp.quicksum(model._vars[t][i, j]
                                        for i, j in combinations(tour, 2))
                            <= len(tour)-1)

# Given a tuplelist of edges, find the shortest subtour
def subtour(edges):
    unvisited = list(range(n))
    cycle = range(n+1)  # initial length has 1 more city
    while unvisited:  # true if list is non-empty
        thiscycle = []
        neighbors = unvisited
        while neighbors:
            current = neighbors[0]
            thiscycle.append(current)
            unvisited.remove(current)
            neighbors = [j for i, j in edges.select(current, '*')
                         if j in unvisited]
        if len(cycle) > len(thiscycle):
            cycle = thiscycle
    return cycle


# Parse argument
if len(sys.argv) < 2:
    print('Usage: atividade2.py npoints')
    sys.exit(1)
n = int(sys.argv[1])

# Create n random points
# define the position of each point in the plane, in float coordinates [0,1]
# the vertices' "names" are [0,n-1].
random.seed(1)
points = [(random.uniform(0,1), random.uniform(0,1)) for i in range(n)]


# Dictionary of Euclidean distance between each pair of points
dist = {(i, j):
        math.sqrt(sum((points[i][k]-points[j][k])**2 for k in range(2)))
        for i in range(n) for j in range(i)}

m = gp.Model("2-TSP")


### START OF MODEL ###

# Variables
vars_x = m.addVars(dist.keys(), obj=dist, vtype=GRB.BINARY)
vars_y = m.addVars(dist.keys(), obj=dist, vtype=GRB.BINARY)

# Add edges in both directions.
for (ix, jx), (iy, jy) in zip(vars_x.keys(), vars_y.keys()):
    vars_x[jx, ix] = vars_x[ix, jx]
    vars_y[jy, iy] = vars_y[iy, jy]

# Objective function
m.setObjective(sum(dist[e]*(vars_x[e] + vars_y[e]) for e in dist.keys()), GRB.MINIMIZE)

# Subject to:
# Degree of each vertex in the tour subgraph.
m.addConstrs(vars_x.sum(i, '*') == 2 for i in range(n))
m.addConstrs(vars_y.sum(i, '*') == 2 for i in range(n))

# Tours need to be edge-disjoint.
m.addConstrs((vars_x[e] + vars_y[e]) <= 1 for e in dist.keys())

### END OF MODEL ###


# Set time limit of 30 minutes.
m.setParam('TimeLimit', 30*60)

# Refresh and save model.
m.update()
m.write(f'2-tsp_{n}cities.lp')

# Optimize model with lazy constraint (subtour)
m._vars = [vars_x,vars_y]
m.Params.lazyConstraints = 1
m.optimize(subtourelim)


# Get solution
vals_x,vals_y = m.getAttr('x', vars_x), m.getAttr('x',vars_y)

selected_x = gp.tuplelist((i, j) for i, j in vals_x.keys() if vals_x[i, j] > 0.5)
selected_y = gp.tuplelist((i, j) for i, j in vals_y.keys() if vals_y[i, j] > 0.5)

# Find tours from selected, assert length.
tour_x = subtour(selected_x)
assert len(tour_x) == n

tour_y = subtour(selected_y)
assert len(tour_y) == n

print('')
print('First tour: %s' % str(tour_x))
print('Second tour: %s' % str(tour_y))
print('Optimal cost: %g' % m.objVal)
print('')
