##########################################################################
#
#   Konstruer grafen 
#
##########################################################################
try
mutable struct Node
    i::Int
    j::Int
    floor::Bool
    neighbors::Array{Node}
    color::Union{String,Nothing}
    distance::Union{Int,Nothing}
    predecessor::Union{Node,Nothing}
end
catch
end
Node(i, j, floor=true) = Node(i, j, floor, [], nothing, nothing, nothing)


### Du skal implementere denne funksjonen ###
function mazetonodelist(maze)
    nodearray::Array{Node} = []
    counter = 1
    cols = size(maze, 1)
    rows = size(maze, 2)
    for i in 1:size(maze, 1)
        for j in 1:size(maze, 2)
            if (maze[i, j] == 1)
                push!(nodearray, Node(i, j, true, [], nothing, nothing, nothing))
                if (j == 1)
                    if (maze[i, j-1] == 1)
                        push!(nodearray[counter].neighbors, Node(i, j-1, true, [], nothing, nothing, nothing))
                    end
                end
                if (j == rows)
                    if (maze[i+1, j] == 1)
                        push!(nodearray[counter].neighbors, Node(i + 1, j, true, [], nothing, nothing, nothing))
                    end
                end
                if (i == 1)
                    if (maze[i, j+1] == 1)
                        push!(nodearray[counter].neighbors, Node(i, j + 1, true, [], nothing, nothing, nothing))
                    end
                end
                    if (i == cols)
                    if (maze[i-1, j] == 1)
                        push!(nodearray[counter].neighbors, Node(i - 1, j, true, [], nothing, nothing, nothing))
                    end
                end
                if (!((j == 1) || (j == rows) || (i == 1) || (i == cols)))
                    if (maze[i, j-1] == 1)
                        push!(nodearray[counter].neighbors, Node(i, j-1, true, [], nothing, nothing, nothing))
                    end
                    if (maze[i-1, j] == 1)
                        push!(nodearray[counter].neighbors, Node(i - 1, j, true, [], nothing, nothing, nothing))
                    end
                    if (maze[i+1, j] == 1)
                        push!(nodearray[counter].neighbors, Node(i + 1, j, true, [], nothing, nothing, nothing))
                    end
                    if (maze[i, j+1] == 1)
                        push!(nodearray[counter].neighbors, Node(i, j + 1, true, [], nothing, nothing, nothing))
                    end
                end
                counter += 1
            end
        end
    end
    return nodearray
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

# (Følgende er hjelpefunksjoner for testene og kan i utgangspunktet ignoreres)
function sortnodelist(nodelist)
    sort!(sort!(nodelist, by=node->node.i), by=node->node.j)
end

function getcoords(nodelist)
    return [(node.i, node.j) for node in nodelist]
end

function getneighborcoords(nodelist)
    return [sort(sort(
               [(neighbor.i, neighbor.j) for neighbor in node.neighbors],
            by = x -> x[1]), by = x -> x[2])
            for node in nodelist]
end

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "LitenLabyrint" begin
    maze = [0 0 0 0 0
            0 1 1 1 0
            0 1 0 0 0
            0 1 1 1 0
            0 0 0 0 0]
    nodelist = mazetonodelist(maze)

    # Test at nodelist er en liste/array med Node-instanser
    # Merk at følgende tester vil feile dersom dette ikke er tilfelet
    @test nodelist isa Array{Node,1}

    # Test at grafen inneholder riktig antall noder
    @test length(nodelist) == 7

    # Vi sorterer nodelist ut ifra koordinatene, ettersom vi ikke pålegger
    # en spesifikk rekkefølge på nodene i nodelist
    sortnodelist(nodelist)

    # Test at koordinatene til hver node er korrekte
    @test getcoords(nodelist) ==
        [(2, 2), (3, 2), (4, 2), (2, 3), (4, 3), (2, 4), (4, 4)]

    # Test at koordinatene til hver nabonode er korrekte
    @test getneighborcoords(nodelist) ==
        [[(3, 2), (2, 3)], [(2, 2), (4, 2)],
         [(3, 2), (4, 3)], [(2, 2), (2, 4)],
         [(4, 2), (4, 4)], [(2, 3)], [(4, 3)]]
end

@testset "MiddelsLabyrint" begin
    maze = [0 0 0 0 0 0 0
            0 1 1 1 1 1 0
            0 1 0 0 0 1 0
            0 1 0 1 0 1 0
            0 1 0 1 0 1 0
            0 1 1 1 0 1 0
            0 0 0 0 0 0 0]
    nodelist = mazetonodelist(maze)

    @test nodelist isa Array{Node,1}

    @test length(nodelist) == 17

    sortnodelist(nodelist)

    @test getcoords(nodelist) ==
        [(2, 2), (3, 2), (4, 2), (5, 2), (6, 2),
         (2, 3), (6, 3), (2, 4), (4, 4), (5, 4),
         (6, 4), (2, 5), (2, 6), (3, 6), (4, 6),
         (5, 6), (6, 6)]

    @test getneighborcoords(nodelist) ==
        [[(3, 2), (2, 3)], [(2, 2), (4, 2)], [(3, 2), (5, 2)],
         [(4, 2), (6, 2)], [(5, 2), (6, 3)], [(2, 2), (2, 4)],
         [(6, 2), (6, 4)], [(2, 3), (2, 5)], [(5, 4)],
         [(4, 4), (6, 4)], [(6, 3), (5, 4)], [(2, 4), (2, 6)],
         [(2, 5), (3, 6)], [(2, 6), (4, 6)], [(3, 6), (5, 6)],
         [(4, 6), (6, 6)], [(5, 6)]]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################


##########################################################################
#
#   Traverser grafen med bredde-først-søk 
#
##########################################################################
using DataStructures: Queue, enqueue!, dequeue!
goal = nothing


function bfs!(nodes, start)
    for i in 1:length(nodes)
        nodes[i].color = "white"
        nodes[i].distance = nothing
        nodes[i].predecessor = nothing
    end
    start.color = "gray"
    start.distance = 0
    start.predecessor = nothing
    currentNode = start
    queueOfNodes = Queue{Node}()
    enqueue!(queueOfNodes, start)
    while (!(isempty(queueOfNodes)))
        currentNode = dequeue!(queueOfNodes)
        for i in 1:length(currentNode.neighbors)
            discoveredNode = currentNode.neighbors[i]
            if (discoveredNode.color == "white")
                discoveredNode.color = "gray"
                discoveredNode.distance = currentNode.distance + 1
                discoveredNode.predecessor = currentNode
                if (isgoalnode(discoveredNode))
                    return discoveredNode
                end
                enqueue!(queueOfNodes, discoveredNode)
            end
        end
        currentNode.color = "black"
    end
    return nothing
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

# (Følgende er hjelpefunksjoner for testene og kan i utgangspunktet ignoreres)
function isgoalnode(node)
    global goal
    node == goal
end

function setgoalnode(node)
    global goal
    goal = node
end

function nodeattrs(node)
    return string(node.color, " ", node.distance, " ",
                  node.predecessor == nothing ? "nothing" :
                  (node.predecessor.i, node.predecessor.j))
end

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "LitenLabyrint" begin
    # maze = [0 0 0 0 0
    #         0 1 1 1 0
    #         0 1 0 0 0
    #         0 1 1 1 0
    #         0 0 0 0 0]

    nodelist = [Node(2, 2), Node(3, 2), Node(4, 2), Node(2, 3),
                Node(4, 3), Node(2, 4), Node(4, 4)]

    nodelist[1].neighbors = [nodelist[2], nodelist[4]]
    nodelist[2].neighbors = [nodelist[1], nodelist[3]]
    nodelist[3].neighbors = [nodelist[2], nodelist[5]]
    nodelist[4].neighbors = [nodelist[1], nodelist[6]]
    nodelist[5].neighbors = [nodelist[3], nodelist[7]]
    nodelist[6].neighbors = [nodelist[4]]
    nodelist[7].neighbors = [nodelist[5]]

    setgoalnode(nothing)
    result = bfs!(nodelist, nodelist[1])

    # Test at å kjøre bfs mot et utilgjengelig mål returnerer nothing
    @test result == nothing

    setgoalnode(nodelist[7])
    result = bfs!(nodelist, nodelist[1])

    # Test at riktig målnode returneres
    @test result == nodelist[7]

    # Test at attributtene til nodene i nodelist ble oppdatert korrekt
    # Attributtene tilsvarer color, distance og koordinatene til predecessor
    # (Merk at fargene kan variere noe ut ifra når man returnerer målnoden)
    @test nodeattrs(nodelist[1]) == "black 0 nothing"
    @test nodeattrs(nodelist[2]) == "black 1 (2, 2)"
    @test nodeattrs(nodelist[3]) == "black 2 (3, 2)"
    @test nodeattrs(nodelist[4]) == "black 1 (2, 2)"
    @test nodeattrs(nodelist[5]) in ["gray 3 (4, 2)", "black 3 (4, 2)"]
    @test nodeattrs(nodelist[6]) == "black 2 (2, 3)"
    @test nodeattrs(nodelist[7]) in ["white 4 (4, 3)", "gray 4 (4, 3)"]
end

@testset "MiddelsLabyrint" begin
    # maze = [0 0 0 0 0 0 0
    #         0 1 1 1 1 1 0
    #         0 1 0 0 0 1 0
    #         0 1 0 1 0 1 0
    #         0 1 0 1 0 1 0
    #         0 1 1 1 0 1 0
    #         0 0 0 0 0 0 0]

    nodelist = [Node(2, 2), Node(3, 2), Node(4, 2), Node(5, 2), Node(6, 2),
                Node(2, 3), Node(6, 3), Node(2, 4), Node(4, 4), Node(5, 4),
                Node(6, 4), Node(2, 5), Node(2, 6), Node(3, 6), Node(4, 6),
                Node(5, 6), Node(6, 6)]

    nodelist[1].neighbors = [nodelist[2], nodelist[6]]
    nodelist[2].neighbors = [nodelist[1], nodelist[3]]
    nodelist[3].neighbors = [nodelist[2], nodelist[4]]
    nodelist[4].neighbors = [nodelist[3], nodelist[5]]
    nodelist[5].neighbors = [nodelist[4], nodelist[7]]
    nodelist[6].neighbors = [nodelist[1], nodelist[8]]
    nodelist[7].neighbors = [nodelist[5], nodelist[11]]
    nodelist[8].neighbors = [nodelist[6], nodelist[12]]
    nodelist[9].neighbors = [nodelist[10]]
    nodelist[10].neighbors = [nodelist[9], nodelist[11]]
    nodelist[11].neighbors = [nodelist[7], nodelist[10]]
    nodelist[12].neighbors = [nodelist[8], nodelist[13]]
    nodelist[13].neighbors = [nodelist[12], nodelist[14]]
    nodelist[14].neighbors = [nodelist[13], nodelist[15]]
    nodelist[15].neighbors = [nodelist[14], nodelist[16]]
    nodelist[16].neighbors = [nodelist[15], nodelist[17]]
    nodelist[17].neighbors = [nodelist[16]]

    setgoalnode(nodelist[17])
    result = bfs!(nodelist, nodelist[1])

    @test result == nodelist[17]

    @test nodeattrs(nodelist[1]) == "black 0 nothing"
    @test nodeattrs(nodelist[2]) == "black 1 (2, 2)"
    @test nodeattrs(nodelist[3]) == "black 2 (3, 2)"
    @test nodeattrs(nodelist[4]) == "black 3 (4, 2)"
    @test nodeattrs(nodelist[5]) == "black 4 (5, 2)"
    @test nodeattrs(nodelist[6]) == "black 1 (2, 2)"
    @test nodeattrs(nodelist[7]) == "black 5 (6, 2)"
    @test nodeattrs(nodelist[8]) == "black 2 (2, 3)"
    @test nodeattrs(nodelist[9]) in ["gray 8 (5, 4)", "black 8 (5, 4)"]
    @test nodeattrs(nodelist[10]) == "black 7 (6, 4)"
    @test nodeattrs(nodelist[11]) == "black 6 (6, 3)"
    @test nodeattrs(nodelist[12]) == "black 3 (2, 4)"
    @test nodeattrs(nodelist[13]) == "black 4 (2, 5)"
    @test nodeattrs(nodelist[14]) == "black 5 (2, 6)"
    @test nodeattrs(nodelist[15]) == "black 6 (3, 6)"
    @test nodeattrs(nodelist[16]) in ["gray 7 (4, 6)", "black 7 (4, 6)"]
    @test nodeattrs(nodelist[17]) in ["white 8 (5, 6)", "gray 8 (5, 6)"]
end


println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################

##########################################################################
#
#   Finn stien til målnoden 
#
##########################################################################


function makepathto(goalnode)
    currentNode = goalnode
    path::Array = []
    while (currentNode.predecessor != nothing)
        push!(path, (currentNode.i, currentNode.j))
        currentNode = currentNode.predecessor
    end
    push!(path, (currentNode.i, currentNode.j))
    path = reverse(path)
    return path
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "LitenLabyrint" begin
    # maze = [0 0 0 0 0
    #         0 1 1 1 0
    #         0 1 0 0 0
    #         0 1 1 1 0
    #         0 0 0 0 0]

    nodelist = [Node(2, 2), Node(3, 2), Node(4, 2), Node(2, 3),
                Node(4, 3), Node(2, 4), Node(4, 4)]

    # startnode = nodelist[1]
    # goalnode = nodelist[7]
    nodelist[1].predecessor = nothing
    nodelist[2].predecessor = nodelist[1]
    nodelist[3].predecessor = nodelist[2]
    nodelist[4].predecessor = nodelist[1]
    nodelist[5].predecessor = nodelist[3]
    nodelist[6].predecessor = nodelist[4]
    nodelist[7].predecessor = nodelist[5]

    # Test at riktig sti returneres
    @test makepathto(nodelist[7]) ==
            [(2, 2), (3, 2), (4, 2), (4, 3), (4, 4)]

end

@testset "MiddelsLabyrint" begin
    # maze = [0 0 0 0 0 0 0
    #         0 1 1 1 1 1 0
    #         0 1 0 0 0 1 0
    #         0 1 0 1 0 1 0
    #         0 1 0 1 0 1 0
    #         0 1 1 1 0 1 0
    #         0 0 0 0 0 0 0]

    nodelist = [Node(2, 2), Node(3, 2), Node(4, 2), Node(5, 2), Node(6, 2),
                Node(2, 3), Node(6, 3), Node(2, 4), Node(4, 4), Node(5, 4),
                Node(6, 4), Node(2, 5), Node(2, 6), Node(3, 6), Node(4, 6),
                Node(5, 6), Node(6, 6)]

    # startnode = nodelist[1]
    # goalnode = nodelist[17]
    nodelist[1].predecessor = nothing
    nodelist[2].predecessor = nodelist[1]
    nodelist[3].predecessor = nodelist[2]
    nodelist[4].predecessor = nodelist[3]
    nodelist[5].predecessor = nodelist[4]
    nodelist[6].predecessor = nodelist[1]
    nodelist[7].predecessor = nodelist[5]
    nodelist[8].predecessor = nodelist[6]
    nodelist[9].predecessor = nodelist[10]
    nodelist[10].predecessor = nodelist[11]
    nodelist[11].predecessor = nodelist[7]
    nodelist[12].predecessor = nodelist[8]
    nodelist[13].predecessor = nodelist[12]
    nodelist[14].predecessor = nodelist[13]
    nodelist[15].predecessor = nodelist[14]
    nodelist[16].predecessor = nodelist[15]
    nodelist[17].predecessor = nodelist[16]

    @test makepathto(nodelist[17]) ==
            [(2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 6), (4, 6), (5, 6), (6, 6)]
end


println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################