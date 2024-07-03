#=
Neue Änderung nach der Rechnerbetreuung. Es funktioniert immer noch nicht aber es ist näher an das Endprogramm
=#
include("core.jl")

function solving_labyrinth(mat::Matrix{Node})::Tuple{Node,Node,Vector}
    start = rand(mat) #??
    exit = rand(mat) #??
    if start.key === exit.key
        return start,exit,[start,exit]
    end
    start_idx = Tuple(findfirst(x -> x.key === start.key,mat))
    exit_idx = Tuple(findfirst(x -> x.key === exit.key,mat))
    path = [(start,nothing)]
    i,j = start_idx
    d = 1
    directions = [(0,1),(-1,0),(0,-1),(1,0)]
    while (i,j) !== exit_idx # bis wir das ziel finden
        while true # bis wir eine mögliche richtung finden
            # können wir in direction d gehen? break
            if mat[i+directions[d][1],j+directions[d][2]] ∈ neighbours(mat[i,j])
                break
            end
            d = d%4 + 1
        end
        i += directions[d][1]
        j += directions[d][2]
        push!(path,(mat[i,j],d)) 
        d = path[end][2]
    end
    return start,exit,path
end






