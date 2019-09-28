
tabell1 = [1 2; 4 3; 5 6; 2 9; 7 1]
tabell2 = [3 4; 2 1; 5 6; 0 2; 1 3; 4 0]

xsortert1 = [0 1; 5 3; 6 1; 8 9]
xsortert2 = [1 0; 2 1; 3 4; 4 2; 5 8;]

# x og y er to sorterte tabeller, coordinate angir koordinat
function mergearrays(x,y,coordinate)
    lengde::Int = size(x, 1) + size(y, 1)
    # result = Array{Float64}(undef, size(x, 1), size(y, 1), 2)
    x = vcat(x, [Inf, Inf])
    y = vcat(y, [Inf, Inf])
    nytabell = []
    i = j = 1
    while(i <= lengde/2)
        if (x[i, coordinate] <= y[j, coordinate])
            # result[i, :] = x[i, :]
            push!(nytabell, x[i, :])
            i = i + 1
        else
            # result[i, :] = y[i, :]
            push!(nytabell, y[j, :])
            j = j + 1
        end
    end
    # return result
    return nytabell
end

# x er en usortert tabell, coordinate angir koordinat vi skal sortere langs
function mergesort(x, coordinate)
    first::Int = 1
    last::Int = size(x, 1)
    if (first < last)
        middle::Int = (first + last - rem(first +last, 2))/2
        tmp1 = []
        tmp2 = []
        for i in 0:(middle - first)
            push!(tmp1, x[first + i, :])
        end
        for j in 0:(last - middle - 1)
            push!(tmp2, x[middle + j + 1, :])
        end
        mergesort(tmp1, coordinate)
        mergesort(tmp2, coordinate)
        mergearrays(tmp1, tmp2, coordinate)
    end
end

print(mergesort(tabell1, 2))
# print(mergearrays(xsortert1, xsortert2, 1))