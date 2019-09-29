
##########################################################################
#
#   Merge sort 
#
##########################################################################
tabell = [1 2; 4 3; 5 6; 2 9; 7 1]

# x og y er to sorterte tabeller, coordinate angir koordinat
function mergearrays(x,y,coordinate)
    sizex = size(x, 1)
    sizey = size(y, 1)
    result = Array{Float64}(undef, sizex + sizey, 2)
    x = vcat(x, [Inf Inf])
    y = vcat(y, [Inf Inf])
    i = 1
    j = 1
    for k in 1:sizex + sizey
        if (x[i, coordinate] <= y[j, coordinate])
            result[k, :] = x[i, :]
            i = i + 1
        else
            result[k, :] = y[j, :]
            j = j + 1
        end
    end
    return result
end

# x er en usortert tabell, coordinate angir koordinat vi skal sortere langs
function mergesort(x, coordinate)
    first::Int = 1
    last::Int = size(x, 1)
    if (first >= last)
        return x
    else
        middle::Int = (first + last - rem(first +last, 2))/2
        part_start = x[first:middle, :]
        part_end = x[middle+1:last, :]
        part_start = mergesort(part_start, coordinate)
        part_end = mergesort(part_end, coordinate)
        return mergearrays(part_start, part_end, coordinate)
    end
end
##########################################################################

##########################################################################
#
#   Split in two
#
##########################################################################
x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]

function splitintwo(x,y)
    first::Int = 1
    last::Int = size(x, 1)
    k = 1
    if (first < last)
        middle::Int = (first + last - rem(first +last, 2))/2
        tmp1 = Array{Float64}(undef, middle, 2)
        tmp2 = Array{Float64}(undef, last - middle, 2)
        tmp3 = Array{Float64}(undef, middle, 2)
        tmp4 = Array{Float64}(undef, last - middle, 2)
        test = Array{Int}(undef, last, 1)
        fill!(test, 0)
        for i in 0:(middle - first)
            tmp1[i + 1, :] = x[i + 1, :]
        end
        for i in 0:(last - middle - 1)
            tmp2[i + 1, :] = x[i + middle + 1, :]
        end
        for i in 0:size(tmp1, 1) - 1
            while (tmp1[i + 1, :] != y[k, :])
                k += 1
            end
            test[k] = 1
            k = 1
        end
        l = 1
        m = 1
        for i in 1:last
            if (test[i] == 1)
                tmp3[l, :] = y[i, :]
                l += 1
            else
                tmp4[m, :] = y[i, :]
                m += 1
            end
        end
    end
    return tmp1, tmp2, tmp3, tmp4
end
##########################################################################


println("mergesort: ", mergesort(tabell, 1))
println("splitintwo: ",splitintwo(x, y))