import sys
import math
import random
from itertools import combinations
import gurobipy as gp
from gurobipy import GRB


# Callback - use lazy constraints to eliminate sub-tours
def subtourelim(model, where):
    if where == GRB.Callback.MIPSOL:
        # make a list of edges selected in the solution
        vals = model.cbGetSolution(model._vars)
        selected = gp.tuplelist((i, j) for i, j in model._vars.keys()
                                if vals[i, j] > 0.5)
        # find the shortest cycle in the selected edge list
        tour = subtour(selected)
        if len(tour) < n:
            # add subtour elimination constr. for every pair of cities in tour
            model.cbLazy(gp.quicksum(model._vars[i, j]
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


n = 20
# Create n random points
# os valores dos pontos randomicos sao utilizados para definir as distancias euclidianas entre eles
# definindo assim as arestas, os "nomes" dos vertices sao de 0 a 19.
random.seed(1)
points = [(random.randint(0, 100), random.randint(0, 100)) for i in range(n)]


# Dictionary of Euclidean distance between each pair of points

dist = {(i, j):
        math.sqrt(sum((points[i][k]-points[j][k])**2 for k in range(2)))
        for i in range(n) for j in range(i)}
for i in range(n):
    for j in range(i):
        dist[(j,i)] = dist[(i,j)]

m = gp.Model()

vars_x = m.addVars(dist.keys(), obj=dist, vtype=GRB.BINARY)
vars_y = m.addVars(dist.keys(), obj=dist, vtype=GRB.BINARY)

m.modelSense = GRB.MINIMIZE
m.setParam('TimeLimit', 30*60)

m.setObjective(sum(dist[e]*(vars_x[e] + vars_y[e]) for e in dist.keys()))


m.addConstrs(vars_x.sum(i, '*') == 2 for i in range(n))
m.addConstrs(vars_y.sum(i, '*') == 2 for i in range(n))


m.addConstrs((vars_x[e] + vars_y[e]) <= 1 for e in dist.keys())

# Optimize model

#print(m.getConstrs())
#m._vars = vars
#m.Params.lazyConstraints = 1
#m.optimize(subtourelim)

#vals = m.getAttr('x', vars)
#selected = gp.tuplelist((i, j) for i, j in vals.keys() if vals[i, j] > 0.5)

#tour = subtour(selected)
#assert len(tour) == n

#print('')
#print('Optimal tour: %s' % str(tour))
#print('Optimal cost: %g' % m.objVal)
#print('')