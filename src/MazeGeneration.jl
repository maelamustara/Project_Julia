include("core.jl")
include("visualize.jl")
include("solver.jl")

height = 5
width = 5
mat = maze(height, width)
mat = random_stack(mat)

# Randomly select start and end nodes
start_node = rand(mat)
goal_node = rand(mat)

# Ensure start and end nodes are different
while goal_node === start_node
    goal_node = rand(mat)
end

path = solve(mat, start_node, goal_node)
show(stdout, MazeViz(mat, path))
