
include("core.jl")
include("visualize.jl")

height = 4
width = 4
mat = maze(height, width)
mat = random_stack(mat)
show(stdout, mat)
