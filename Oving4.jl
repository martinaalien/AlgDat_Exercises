
##########################################################################
#
#    Implementer tellesortering på strenger
#
##########################################################################
stringlist1 = ["ccc", "cba", "ca", "ab", "abc"]

function countingsortletters(A,position)
    C = zeros(Int, 1, 26)
    B = Array{String}(undef, length(A))
    for i in 1:length(A)
        C[chartodigit(A[i][position])] = C[chartodigit(A[i][position])] + 1 
    end
    for i in 2:length(C)
        C[i] = C[i] + C[i-1]
    end
    for i in length(A):-1:1
        B[C[chartodigit(A[i][position])]] = A[i]
        C[chartodigit(A[i][position])] = C[chartodigit(A[i][position])] - 1
    end
    return B
end

function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.

    return character - '`'
end

println(countingsortletters(stringlist1, 2))
##########################################################################

##########################################################################
#
#    Implementer tellesortering på strenger etter lengde
#
##########################################################################
stringlist2 = ["bbbb", "", "aaaater", "ccc"]

function countingsortlength(A)
    max::Int = 0
    for i in 1:length(A)
        if (max < length(A[i]))
            max = length(A[i])
        end
    end
    C = zeros(Int, 1, max + 1)
    B = Array{String}(undef, length(A))
    for i in 1:length(A)
        C[length(A[i]) + 1] = C[length(A[i]) + 1] + 1
    end
    for i in 2:length(C)
        C[i] = C[i] + C[i-1]
    end
    for i in length(B):-1:1
        B[C[length(A[i]) + 1]] = A[i]
        C[length(A[i]) + 1] = C[length(A[i]) + 1] - 1
    end
    return B
end

println(countingsortlength(stringlist2))
##########################################################################

##########################################################################
#
#  Flexradix 
#
##########################################################################
stringlist3 = ["kobra", "aggie", "agg", "kort", "hyblen"]

function flexradix(A, maxlength)
    tmp1 = String[]
    for i in maxlength:-1:1
        tmp2 = filter(e -> length(e) == i, A)

        if length(tmp2) != 0
            prepend!(tmp1, tmp2)
        end
        tmp1 = countingsortletters(tmp1, i)
    end
    prepend!(tmp1, filter(e -> e == "", A))
    return tmp1
end

println(flexradix(stringlist3, 6))
##########################################################################