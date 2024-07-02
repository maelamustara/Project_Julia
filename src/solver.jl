#=
Das Funktioniert auch nicht :D es gibt ein Problem bei den Richtungen, in denen der path gefolgt wird
=#
function solving_labyrinth(start::Node,exit::Node,mat::Matrix{Node})::Vector{Node}
    if start.key === exit.key
        return [start,exit]
    end
    start_idx = Tuple(findfirst(x -> x.key === start.key,mat))
    exit_idx = Tuple(findfirst(x -> x.key === exit.key,mat))
    path = [start]
    i,j = start_idx
    println(start_idx)
    println(exit_idx)
    while (i,j) !== exit_idx
        println(i,j)
        if mat[i,j].right !== nothing
            i,j = i,j+1
            push!(path,mat[i,j])
        elseif mat[i,j].up !== nothing
            i,j = i-1,j
            push!(path,mat[i,j])
        elseif mat[i,j].left !== nothing
            i,j = i,j-1
            push!(path,mat[i,j])
        elseif mat[i,j].down !== nothing
            i,j = i+1,j
            push!(path,mat[i,j])
        end
    end
    return path
end




