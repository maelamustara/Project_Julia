struct MazeViz
    mat::Matrix{Node}
    path::Vector{Node}
end

# Function to draw the maze with the solution path in the terminal
function draw_maze(viz::MazeViz)
    mat = viz.mat
    path = viz.path
    height, width = size(mat)
    output = IOBuffer()

    function node_position(mat, target_node)
        for i in 1:size(mat, 1)
            for j in 1:size(mat, 2)
                if mat[i, j] === target_node
                    return (i, j)
                end
            end
        end
        return nothing
    end

    # Draw the maze with walls
    for i in 1:height
        # Draw the top boundary of the row
        for j in 1:width
            node = mat[i, j]
            if node.up === nothing
                print(output, "+---")
            else
                print(output, "+   ")
            end
        end
        println(output, "+")

        # Draw the side boundaries of the row
        for j in 1:width
            node = mat[i, j]
            if node.left === nothing
                print(output, "|")
            else
                print(output, " ")
            end

            if node in path
                if node === path[1]
                    print(output, " S ")
                elseif node === path[end]
                    print(output, " E ")
                else
                    # Determine the direction symbol
                    idx = findfirst(==(node), path)
                    if idx < length(path)
                        next_node = path[idx + 1]
                        current_pos = node_position(mat, node)
                        next_pos = node_position(mat, next_node)
                        if next_pos[1] < current_pos[1]
                            print(output, " ↑ ")
                        elseif next_pos[1] > current_pos[1]
                            print(output, " ↓ ")
                        elseif next_pos[2] < current_pos[2]
                            print(output, " ← ")
                        elseif next_pos[2] > current_pos[2]
                            print(output, " → ")
                        end
                    end
                end
            else
                print(output, "   ")
            end
        end
        println(output, "|")
    end

    # Draw the bottom boundary of the last row
    for j in 1:width
        print(output, "+---")
    end
    println(output, "+")

    return String(take!(output))
end

# Overload Base.show for MazeViz to display the maze
function Base.show(io::IO, viz::MazeViz)
    print(io, draw_maze(viz))
end

# Overload Base.show for the matrix of Nodes
function Base.show(io::IO, mat::Matrix{Node})
    viz = MazeViz(mat, Vector{Node}())
    show(io, viz)
end

# Overload Base.show for the matrix of Nodes with the solution path
function Base.show(io::IO, mat::Matrix{Node}, path::Vector{Node})
    viz = MazeViz(mat, path)
    show(io, viz)
end
