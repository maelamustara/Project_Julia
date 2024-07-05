using Random

# Definition of Node struct
mutable struct Node
    key::Int #dosnt make sence, need to change it in position 
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    up::Union{Node, Nothing}
    down::Union{Node, Nothing}
end

# Outer constructors for the Node struct
function node(key::Int)::Node
    return Node(key, nothing, nothing, nothing, nothing)
end

function node(key::Int, left::Union{Node, Nothing}, right::Union{Node, Nothing}, up::Union{Node, Nothing}, down::Union{Node, Nothing})::Node
    return Node(key, left, right, up, down)
end

# Function to get all non-nothing neighbors of a node
function neighbours(node::Node)::Vector{Node}
    return filter(x -> x !== nothing, [node.left, node.right, node.up, node.down])
end

# Function to create a matrix of nodes
function maze(height::Int, width::Int)::Matrix{Node}
    @assert height * width >= 1
    possible_keys = shuffle!(collect(-99:99))
    mat = Matrix{Node}(undef, height, width)
    idx = 1
    for n in 1:height
        for m in 1:width
            mat[n, m] = node(possible_keys[idx]) #in Tuple von n,m
            idx += 1
        end
    end
    return mat
end

# Function to get the indices of possible neighbors in the matrix
function neighbours_in_matrix(mat::Matrix{Node}, i::Int, j::Int)::Vector{Tuple{Int, Int}}
    m, n = size(mat)
    neighbours = Vector{Tuple{Int, Int}}()
    if i > 1
        push!(neighbours, (i - 1, j))
    end
    if i < m
        push!(neighbours, (i + 1, j))
    end
    if j > 1
        push!(neighbours, (i, j - 1))
    end
    if j < n
        push!(neighbours, (i, j + 1))
    end
    return neighbours
end

#= 
Ich habe Output der random_stack Funktion geändert, sodass man in dieser Funktion schon Start und Ende
des Labyrinths definieren kann. Das brauchen wir für die Visualisierung. Wenn man Labyrinth ohne Start und Ausgang des
Labyrinths visualisieren möchte, dann einfach random_stack(A)[1] nehmen. Wenn die random_stack-Funktion so geändert 
wird, muss man auch MazeViz-Struct dementsprechend ändern, sonst können Start und Ziel nicht visualisiert werden. Ich
habe etwas in der Datei visualize geschrieben
=#
function random_stack(mat::Matrix{Node})::Tuple{Matrix{Node},Node,Node}
    @assert (size(mat)[1] > 1 && size(mat)[2] > 1)
    root = rand(mat)
    root_idx = Tuple(findfirst(x -> x.key === root.key, mat))
    stack = [root]
    visited = Set([root_idx])

    while !isempty(stack)
        node = stack[end]
        i, j = Tuple(findfirst(x -> x.key === node.key, mat))
        unvisited_neighbours = setdiff(neighbours_in_matrix(mat, i, j), visited)

        if !isempty(unvisited_neighbours)
            k, l = rand(unvisited_neighbours)
            push!(stack, mat[k, l])

            if (k, l) == (i - 1, j)
                node.up = mat[k, l]
                mat[k, l].down = node
            elseif (k, l) == (i + 1, j)
                node.down = mat[k, l]
                mat[k, l].up = node
            elseif (k, l) == (i, j - 1)
                node.left = mat[k, l]
                mat[k, l].right = node
            elseif (k, l) == (i, j + 1)
                node.right = mat[k, l]
                mat[k, l].left = node
            end

            push!(visited, (k, l))
        else
            pop!(stack)
        end
    end

    return mat,rand(mat),rand(mat)
end


