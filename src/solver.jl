include("core.jl")

# Function to find the direction to the right given the current direction
function turn_right(dir::Symbol)::Symbol
    directions = [:up, :right, :down, :left]
    return directions[mod(findfirst(==(dir), directions), 4) + 1]
end

# Function to find the direction to the left given the current direction
function turn_left(dir::Symbol)::Symbol
    directions = [:up, :right, :down, :left]
    return directions[mod(findfirst(==(dir), directions) - 2, 4) + 1]
end

# Function to move in a given direction
function move(node::Node, dir::Symbol)
    if dir == :up
        return node.up
    elseif dir == :right
        return node.right
    elseif dir == :down
        return node.down
    elseif dir == :left
        return node.left
    end
end

# Function to solve the maze using the right-hand rule
function solve(maze::Matrix{Node}, start_node::Node, goal_node::Node)::Vector{Node}
    current_node = start_node
    current_direction = :right
    path = [current_node]

    while current_node !== goal_node
        right_direction = turn_right(current_direction)
        next_node = move(current_node, right_direction)
        
        if next_node !== nothing
            current_direction = right_direction
        else
            next_node = move(current_node, current_direction)
            if next_node === nothing
                current_direction = turn_left(current_direction)
                continue
            end
        end

        push!(path, next_node)
        current_node = next_node
    end

    return path
end
