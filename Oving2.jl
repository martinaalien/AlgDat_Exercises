testarray = [10, 6, 7, 3, 7, 77]

mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end

mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end

function createLinkedListDoublyLinked(length)
    # Create the list from the last element in the chain
    # This is so the returned element will be the first in the chain
    current = nothing
    beforeCurrent = nothing

    for i in 1:length
        # only fill out the next field because prev will be filled out later
        current = NodeDoublyLinked(nothing, beforeCurrent, rand(-100:100))
        # link up the node before this node to this node
        if beforeCurrent != nothing
            beforeCurrent.prev = current
        end
        beforeCurrent = current
    end
    return current
end

function findindexinlist(linkedlist, index)
    i = 1
    while(i < index && linkedlist.next != nothing)
        linkedlist = linkedlist.next
        i += 1
    end
    if (i < index)
        return -1
    else
        return linkedlist.value
    end
end 

function reverseandlimit(array, maxnumber)
    array = reverse(array)
    for i in 1:length(array)
        if (array[i] > maxnumber)
            array[i] = maxnumber
        end
    end
    return array
end

function maxofdoublelinkedlist(linkedlist)
x = linkedlist
max = linkedlist.value
while(x != nothing)
    if (max < x.value)
        max = x.value
    end
    x = x.next
end
while(linkedlist != nothing)
    if(max < linkedlist.value)
        max = linkedlist.value
    end
    linkedlist = linkedlist.prev
end
return max
end

println(findindexinlist(createlinkedlist(10), 11))

println(reverseandlimit(testarray, 10))

println(maxofdoublelinkedlist(createLinkedListDoublyLinked(10)))

