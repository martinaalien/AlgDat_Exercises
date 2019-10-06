##########################################################################
#
#   Sammenlike DNA-sekvenser
#
##########################################################################
function dnasimilarity(s1, s2)
simnum = 0;
for i in 1:length(s1)
    if (s1[i] == s2[i])
        simnum += 1
    end
end
return simnum
end

### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test dnasimilarity("A", "A") == 1
	@test dnasimilarity("A", "T") == 0
	@test dnasimilarity("ATCG", "ATGC") == 2
	@test dnasimilarity("ATATATA", "TATATAT") == 0
	@test dnasimilarity("ATGCATGC", "ATGCATGC") == 8
	@test dnasimilarity("CAATAAGGATCTGGTAGCTT", "CCTTACTGAAGCCGCTATGC") == 6
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################

##########################################################################
#
#   Søke i tre 
#
##########################################################################
try
mutable struct Node
    children::Dict{Char,Node}
    count::Int
end
catch
	println("Node() allerede definert")
end


function searchtree(root, dna)
    i = 1
    dnaend = length(dna)
    currentnode = root
    while (i <= dnaend)
        if (!haskey(currentnode.children, dna[i]))
            return 0
        end
        currentnode = currentnode.children[dna[i]]
        if (i == dnaend)
            return currentnode.count
        end
        i +=1
    end
    return 0
end

### Konstruert testdata, la stå ###
root1 = Node(Dict('A' => Node(Dict{Char,Node}(), 1),'G' => 
        Node(Dict('A' => Node(Dict{Char,Node}(), 2)), 1)), 0)
root2 = Node(Dict('A' => Node(Dict{Char,Node}(), 1),'G' => 
        Node(Dict('A' => Node(Dict{Char,Node}(), 1),'G' => 
        Node(Dict{Char,Node}(), 1)), 1),'T' =>
        Node(Dict('G' => Node(Dict('T' => Node(Dict{Char,Node}(), 1)), 0),'T' =>
        Node(Dict('G' => Node(Dict{Char,Node}(), 1)), 0)), 0),'C' => 
        Node(Dict('C' => Node(Dict('A' => Node(Dict{Char,Node}(), 1)), 1)), 1)), 0)

s1 = "AG"
s2 = "GA"
s3 = "TGT"


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test searchtree(root1, s1) == 0
	@test searchtree(root1, s2) == 2
	@test searchtree(root1, s3) == 0
	@test searchtree(root2, s1) == 0
	@test searchtree(root2, s2) == 1
	@test searchtree(root2, s3) == 1
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################

##########################################################################
#
#   Søke i tre 
#
##########################################################################
### Denne må med når en tester lokalt ###
# (try-catch er bare for å unngå feilmelding om redefinition of constant struct)
try
	mutable struct Node
    	children::Dict{Char,Node}
    	count::Int
	end
catch
	println("Node() allerede definert")
end
Node() = Node(Dict(), 0)

### Denne funksjonen overlagrer/definerer likhet for Node-objektet
import Base: ==
(==)(a::Node, b::Node) = a.count == b.count && a.children == b.children


function buildtree(dnasequences)
    root = Node()
    # Alle sekvenser har den tomme strengen som prefix:
    root.count = length(dnasequences)
    currentnode = root
    # Din kode
    for i in 1:size(dnasequences, 1)
        for j in 1:length(dnasequences[i])
            if (!haskey(currentnode.children, dnasequences[i][j]))
                currentnode.children[dnasequences[i][j]] = Node()
                currentnode = currentnode.children[dnasequences[i][j]]
                currentnode.count = 1
            else
                currentnode = currentnode.children[dnasequences[i][j]]
                currentnode.count += 1
            end
        
        end
        currentnode = root
    end
    return root
end

### Konstruert testdata, la stå ###
dnasequences1 = ["A"]
dnasequences2 = ["A", "T", "C", "G"]
dnasequences3 = ["AG", "AGT", "AGTA", "AGTT", "AGTC"]
dnasequences4 = vcat(dnasequences1, dnasequences2, dnasequences3)

tree1 = Node(Dict('A' => Node(Dict{Char,Node}(), 1)), 1)
tree2 = Node(Dict('A' => Node(Dict{Char,Node}(), 1),'G' => 
        Node(Dict{Char,Node}(), 1),'T' => Node(Dict{Char,Node}(), 1),'C' => 
        Node(Dict{Char,Node}(), 1)), 4)
tree3 = Node(Dict('A' => Node(Dict('G' => Node(Dict('T' => Node(Dict('A' => 
        Node(Dict{Char,Node}(), 1),'T' => Node(Dict{Char,Node}(), 1),'C' => 
        Node(Dict{Char,Node}(), 1)), 4)), 5)), 5)), 5)
tree4 = Node(Dict('A' => Node(Dict('G' => Node(Dict('T' => Node(Dict('A' => 
        Node(Dict{Char,Node}(), 1),'T' => Node(Dict{Char,Node}(), 1),'C' => 
        Node(Dict{Char,Node}(), 1)), 4)), 5)), 7),'G' => Node(Dict{Char,Node}(), 1),'T' => 
        Node(Dict{Char,Node}(), 1),'C' => Node(Dict{Char,Node}(), 1)), 10)

        ### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test buildtree(dnasequences1) == tree1
	@test buildtree(dnasequences2) == tree2
    @test buildtree(dnasequences3) == tree3
	@test buildtree(dnasequences4) == tree4
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################
