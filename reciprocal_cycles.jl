#  Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

function longest_reciprocal_cycle()
    longest_cycle_number = 0
    longest_cycle_length = 0
    for i = 2:999
        current_cycle_length = division(i)
        if current_cycle_length > longest_cycle_length
            longest_cycle_length = current_cycle_length
            longest_cycle_number = i
        end
    end
    println("The longest cycle number: ", longest_cycle_number)
    println("The longest cycle length is: ", longest_cycle_length)
    return longest_cycle_number
end

function division(d)
    remainders = []
    current_remainder = 10
    push!(remainders, current_remainder)
    while true
        if current_remainder == 0
            return 0
        elseif current_remainder < d
            current_remainder *= 10
        else
            current_remainder = current_remainder % d
            current_remainder *= 10
        end
        if current_remainder in remainders
            index = findall(x -> x == current_remainder, remainders)
            return length(remainders) - index[1] + 1
        end
        push!(remainders, current_remainder)
    end
end

println("The value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part is: " *string(longest_reciprocal_cycle()))