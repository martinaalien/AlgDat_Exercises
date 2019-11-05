##########################################################################
#
#   Implementer Find-Set 
#
##########################################################################
try
mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end
catch
end

function findset(x)
    if (x != x.p)
        x.p = findset(x.p)
    end
    return x.p
end
##########################################################################

##########################################################################
#
#   Implementer Union  
#
##########################################################################
function union!(x, y)
    x = findset(x)
    y = findset(y)
    if (x.rank > y.rank)
        y.p = x
        return x
    else
        x.p = y
        if (x.rank == y.rank)
            y.rank += 1
        end
        return y
    end
end
##########################################################################

##########################################################################
#
#   Implementer Hamming-avstand 
#
##########################################################################

function hammingdistance(s1, s2)
    dist = 0
    for i in 1:length(s1)
        if (s1[i] != s2[i])
            dist +=1
        end
    end
    return dist
end
##########################################################################

##########################################################################
#
#   Implementer Hamming-avstand 
#
##########################################################################

function findclusters(E, n, k)
    # E = sort!(E)
    # result::Array{Array} = []
    # nodes::Array{DisjointSetNode} = []

    # for i in 1:length()

    # for i in 1:length(E)
    #     if (findset(E[i][2]) != E[i][3])
    #         result
    #     end
    # end
    
    # for i in 1:k

    #     if (length(E[i:k]) > (k + 1))
    #         push!(result[i], )
    #     end
    # end
    # return result

    sorted_edges = sort!(E)
    nodes = DisjointSetNode[]
    for i in 1:n
        push!(nodes, DisjointSetNode())
    end
    while n > k
        current_edge = popfirst!(sorted_edges) # (w,u,v)
        node_u = nodes[current_edge[2]]
        node_v = nodes[current_edge[3]]
        if findset(node_u) != findset(node_v)
            union!(node_u, node_v)
            n -= 1
        end
    end
    representatives = DisjointSetNode[] 
    representative = findset(nodes[1])
    push!(representatives, representative)
    for i in 2: length(nodes)
        test = false
        for x in 1: length(representatives)
            if findset(nodes[i]) == representatives[x]
                test = true 
                break
            end
        end
        if ! test 
            representative = findset(nodes[i])
            push!(representatives, representative)
        end
        if length(representatives) == k 
            break
        end
    end
    return_list = []
    for x in 1: length(representatives)
        parent = representatives[x]
        cluster = []
        for i in 1: length(nodes)
            if parent == findset(nodes[i])
                push!(cluster, i)
            end
        end
        push!(return_list, cluster)             
    end
    return return_list
end


printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2)]) == sort([[1, 2], [3, 4]])
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)]) == sort([[1], [2], [3, 4]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
##########################################################################


##########################################################################
#
#   Finn dyreklynger 
#
##########################################################################

function findanimalgroups(animals, k)
    edges = Tuple[]
    for i in 1:length(animals)
        for x in 1:length(animals)
            if x == i
                continue    #Prevent "loop" edge
            end
            w = hammingdistance(animals[i][2], animals[x][2])
            edge = (w, i, x)
            push!(edges, edge)
        end
    end
    list = findclusters(edges, size(animals, 1), k)
    return_list = []
    for i in 1:k
        push_list = String[]
        for element in list[i]
            push!(push_list,animals[element][1])
        end
        push!(return_list, push_list)
    end
    return return_list
end

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")], 2)]) == sort([["Ugle"], ["Elg", "Hjort"]])

    @test sort([sort(x) for x in findanimalgroups([("Hval", "CGCACATA"), ("Ulv", "AGAAACCT"), ("Delfin", "GGCACATA"), ("Hund", "GGAGACAA"), 
    ("Katt", "TAACGCCA"), ("Leopard", "TAACGCCT")], 3)]) == sort([["Hund", "Ulv"], ["Delfin", "Hval"], ["Katt", "Leopard"]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")

##########################################################################