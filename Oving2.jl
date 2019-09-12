mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
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

function findindexinlist(linkedlist, index)
    i = 0
    VALUEVAR = 0
    NEXTVAR = Union{Node, Nothing}
    if (false)
        return -1
    else
        while(i < index)
            NEXTVAR = linkedlist.next
            i += 1
        end
        return linkedlist.value
    end 
end

node = createlinkedlist(10)

println(findindexinlist(node, 5))
println(node)

