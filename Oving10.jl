##########################################################################
#
#   General Dijkstra 
#
##########################################################################
using DataStructures: PriorityQueue, enqueue!, dequeue!
try
# Deklarering av Node, og Graph:
mutable struct Node
    name::String # used to distinguish nodes when debugging
    d::Union{Float64, Nothing} # d for distance
    p::Union{Node, Nothing} # p for predecessor
end
catch
end

Node(name) = Node(name, nothing, nothing) # constructor used for naming nodes

mutable struct Graph
    V::Array{Node} # V for Vertices
    Adj::Dict{Node, Array{Node}} # Adj for Adjacency
end


function general_dijkstra!(G, w, s, reverse=false)
    initialize!(G, s)
    Q = PriorityQueue(u => u.d for u in G.V)
    if (reverse == true)
        Q = PriorityQueue(Q, Base.Order.Reverse)
    end
    while (!(isempty(Q)))
        u = dequeue!(Q)
        for v in G.Adj[u]
            update!(u, v, w)
            if (haskey(Q, v))
                Q[v] = v.d
            end
        end
    end
end
##########################################################################

##########################################################################
#
#   Widest path 
#
##########################################################################
function initialize!(G, s)
    for v in G.V
       v.d = -typemax(Float64)
       v.p = nothing
    end
    s.d = typemax(Float64)
end


function update!(u, v, w)
    if (v.d < min(u.d, w[(u, v)]))
        v.d = min(u.d, w[(u, v)])
        v.p = u 
    end
end
##########################################################################