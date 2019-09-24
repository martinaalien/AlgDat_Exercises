
tabell1 = [1 2; 4 3; 5 6; 2 9; 7 1]
tabell2 = [3 4; 2 1; 5 6; 0 2; 1 3; 4 0]

xsortert1 = [0 1; 5 3; 6 1; 8 9; Inf Inf]
xsortert2 = [1 0; 2 1; 3 4; 5 8; Inf Inf]

# x og y er to sorterte tabeller, coordinate angir koordinat
function mergearrays(x,y,coordinate)
    lengde = (length(x) + length(y))/2
    # append!(x, [Inf Inf])
    # append!(y, [Inf Inf])
    nytabell = []
    i = j = 1
    while(i <= lengde/2 - 1)
        if (x[i, coordinate] <= y[j, coordinate])
            push!(nytabell, x[i, :])
            i = i + 1
        else
            push!(nytabell, y[j, :])
            j = j + 1
        end
    end
    return nytabell
end

# x er en usortert tabell, coordinate angir koordinat vi skal sortere langs
function mergesort(x, coordinate)

end
print(mergearrays(xsortert1, xsortert2, 1))