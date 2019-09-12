

A = [997, 2, 5, 3, 9, 0, 1, 323, 0, 1, 1, 1, 6, 5]

function insertionsort!(A)
 for i=1:length(A)-1
    j = i
    k = A[j+1]
    while j > 0 && A[j] > k
        A[j+1] = A[j]
        j -= 1
    end
    A[j+1] = k
 end
end

insertionsort!(A)
println(A)