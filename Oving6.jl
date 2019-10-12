##########################################################################
#
#    Finne lengden på den lengste strengt økende delfølgen 
#
##########################################################################

### Du skal implementere denne funksjonen ###
function lislength(s)
    mls = ones(Int, size(s))
    for i = 2:length(s)
        for j = 1:i-1
            if ((s[i] > s[j]) && (mls[i] < mls[j] + 1))
                mls[i] = mls[j] + 1
            end
        end
    end
    return maximum(mls) # Returnerer det største tallet i listen
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test lislength([5,3,3,6,7]) == 3
	@test lislength([2,2,2,2]) == 1
	@test lislength([100,50,25,10]) == 1
	@test lislength([0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]) == 6
	@test lislength([682, 52, 230, 441, 1000, 22, 678, 695, 0, 681]) == 5
    @test lislength([441, 1000, 22, 678, 695, 0, 681, 956, 48, 587, 604,
    857, 689, 346, 425, 513, 476, 917, 114, 43, 327, 172, 162, 76, 91, 
    869, 549, 883, 679, 812, 747, 862, 228, 368, 774, 838, 107, 738, 717,
    25, 937, 927, 145, 44, 634, 557, 850, 965]) == 12
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################

##########################################################################
#
#    Finne den lengste økende delfølgen 
#
##########################################################################
function lis(s, mls)
    ml = maximum(mls)
    lis = zeros(Int, ml)
    for i = length(mls):-1:1
        if (mls[i] == ml)
            lis[ml] = s[i]
            ml -=1
        end
    end
    return lis
end

### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test lis([5,3,3,6,7],[1, 1, 1, 2, 3]) == [3,6,7]
	@test lis([2,2,2,2],[1, 1, 1, 1]) == [2]
	@test lis([100,50,25,10],[1, 1, 1, 1]) == [10]
    @test lis([0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15],
    [1, 2, 2, 3, 2, 3, 3, 4, 2, 4, 3, 5, 3, 5, 4, 6]) == [0,2,6,9,11,15]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################

##########################################################################
#
#    Finn vektene 
#
##########################################################################
function cumulative(weights)
    rows, cols = size(weights)
    min = -Inf
    for i in 1:rows-1
        for j in 1:cols
            if (j == 1)
                min = minimum(weights[i, 1:2])
                weights[i+1, 1] = min + weights[i+1, 1]
            elseif (j == cols)
                min = minimum(weights[i, j-1:j])
                weights[i+1, j] = min + weights[i+1, j]
            else
                min = minimum(weights[i, j-1:j+1])
                weights[i+1, j] = min + weights[i+1, j] 
            end
        end
    end
    return weights
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test cumulative([1 1 ; 1 1]) == [1 1 ;2 2]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test cumulative([3  6  8 6 3; 7  6  5 7 3; 4  10 4 1 6; 10 4  3 1 2;6  1  7 3 9])== [3  6  8  6  3;10 9  11 10 6;13 19 13 7  12;23 17 10 8  9;23 11 15 11 17]
end


println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################