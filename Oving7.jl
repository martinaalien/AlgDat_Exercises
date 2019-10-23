##########################################################################
#
#   Er grådighet korrekt? 
#
##########################################################################

function usegreed(coins)
    for i in 1:length(coins)-1
        if (coins[i] % coins[i+1] != 0)
            return false
        end
    end
    return true
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test usegreed([20, 10, 5, 1]) == true
  @test usegreed([20, 15, 10, 5, 1]) == false
  @test usegreed([100, 1]) == true
  @test usegreed([5, 4, 3, 2, 1]) == false
  @test usegreed([1]) == true

end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################


##########################################################################
#
#   Grådig løsning 
#
##########################################################################

function mincoinsgreedy(coins, value)
    i = 1
    numberOfCoins::Int64 = 0
    while (value > 0)
        if (value >= coins[i])
            numberOfCoins += floor(value/coins[i])
            value -= floor(value/coins[i])*coins[i]
        end 
        i += 1
    end
    return numberOfCoins
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoinsgreedy([1000,500,100,20,5,1],1226) == 6
  @test mincoinsgreedy([20,10,5,1],99) == 10
  @test mincoinsgreedy([5,1],133) == 29
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################


##########################################################################
#
#   Grådig løsning 
#
##########################################################################

function mincoins(coins, value)
    if (usegreed(coins))
        return mincoinsgreedy(coins, value)
    else
        table = Array{Int64}(undef, value + 1)
        table[1] = 0
        tmpRes = 0
        inf = typemax(Int)
        for i in 2:value+1
            table[i] = inf
        end
        for i in 2:value+1
            for j in 1:length(coins)
                if (coins[j] < i)
                    tmpRes = table[i - coins[j]]
                    if ((tmpRes != inf) & (tmpRes + 1 < table[i]))
                        table[i] = tmpRes + 1
                    end
                end
            end
        end
        return table[value + 1]
    end
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoins([4,3,1],18) == 5
  @test mincoins([1000,500,100,30,7,1],14) == 2
  @test mincoins([40, 30, 20, 10, 1], 90) == 3
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
##########################################################################