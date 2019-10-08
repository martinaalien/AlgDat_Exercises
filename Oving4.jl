
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

    # Sort A after length. This must be done as the 
    # following algorithm can't sort for example 
    # ['ab', 'a'] in the right order so it must be
    # done by length  
    A = countingsortlength(A)
    

    for digit in maxlength:-1:1
        
        # This array will include the words in A that 
        # have length of digit or more
        words = []
        # This array will include the indexes from A that
        # have a number that has a length of digit or more
        indexes = []

        # Find the elements with length longer than digit
        for i in 1:length(A)
            if length(A[i]) >= digit
                push!(words, A[i])
                push!(indexes, i)
            end
        end
        
        # Sort these words at position digit
        words = countingsortletters(words, digit)

        # Replace the indexes we took elements from in A 
        # with the now sorted values 
        for i in 1:length(words)
            A[indexes[i]] = words[i]
        end
        
    end

    return A
end

println(flexradix(stringlist3, 6))
##########################################################################