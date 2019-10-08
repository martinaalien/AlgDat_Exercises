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
    for i in 1:dnaend
        if (!haskey(currentnode.children, dna[i]))
            return 0
        end
        currentnode = currentnode.children[dna[i]]
        if (i == dnaend)
            return currentnode.count
        end
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

##########################################################################
#
#   Søk med ødelagt DNA 
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




### Du skal implementere denne funksjonen ###
function brokendnasearch(root, dna, i=1)
    letter = Char(dna[i])
    count_matches = 0
    if i  ==  length(dna)
        if letter != '?'
            child = get(root.children, letter, 0)
            if child == 0
                return 0
            end
            return child.count
        end 
        last_count = 0 
        for key in keys(root.children)
            child = root.children[key]
            last_count += child.count
        end
        return last_count 
    end
    if letter == '?'
        for children in keys(root.children)
            child = root.children[children]
            count_matches += brokendnasearch(child, dna, i+1)
        end
    else
        child = get(root.children, letter, 0)
        if child == 0
            return 0 
        end
        count_matches += brokendnasearch(child, dna, i+1)
    end
    return count_matches
end


### Konstruert testdata, la stå ###
root1 = Node(Dict('A' => Node(Dict{Char,Node}(), 1)), 0)
root2 = Node(Dict('A' => Node(Dict('G' => Node(Dict('T' => Node(Dict('A' => 
        Node(Dict{Char,Node}(), 1),'T' => Node(Dict{Char,Node}(), 1),'C' => 
        Node(Dict{Char,Node}(), 1)), 4)), 5)), 5)), 0)
root3 = Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => 
        Node(Dict('C' => Node(Dict('C' => Node(Dict{Char,Node}(), 1)), 2)), 3)), 4)), 5)), 6)), 0)

s1 = "A"
s2 = "T"
s3 = "?"
s4 = "??"
s5 = "C?C"
s6 = "???"
s7 = "?????"




### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test brokendnasearch(root1, s1) == 1
	@test brokendnasearch(root1, s2) == 0
	@test brokendnasearch(root1, s3) == 1
	@test brokendnasearch(root1, s4) == 0
	@test brokendnasearch(root2, s1) == 5
	@test brokendnasearch(root2, s3) == 5
	@test brokendnasearch(root2, s4) == 5
	@test brokendnasearch(root2, s5) == 0
	@test brokendnasearch(root2, s6) == 4
	@test brokendnasearch(root3, s5) == 4
	@test brokendnasearch(root3, s6) == 4
	@test brokendnasearch(root3, s7) == 2
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################