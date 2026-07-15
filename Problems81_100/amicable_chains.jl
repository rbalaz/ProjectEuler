#  Find the smallest member of the longest amicable chain with no element exceeding one million.

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

function create_proper_factors_sum_lookup(limit)
    lookup = zeros(Int, limit)
    for i in 2:limit
        factors = get_factors(i)
        # Remove the number itself
        deleteat!(factors, 2)
        lookup[i] = sum(factors)
    end
    return lookup
end

amicable_chain_limit = 1_000_000
longest_chain_length = 0
longest_chain_starting_number = 0
smallest_member_of_longest_chain = typemax(Int)
factorials_sum_lookup = create_proper_factors_sum_lookup(amicable_chain_limit)

for i in 1:amicable_chain_limit
    current = i
    current_smallest = i
    current_chain = Set{Int}()
    push!(current_chain, current)

    while true
        current = factorials_sum_lookup[current]
        if current == 0 || current > amicable_chain_limit
            break
        end

        if current in current_chain
            if current != i
                # Invalid amicable chain, since it doesn't loop back to the starting number
                break
            end
            
            current_chain_length = length(current_chain)
            if current_chain_length > longest_chain_length
                global longest_chain_length = current_chain_length
                global longest_chain_starting_number = i
                global smallest_member_of_longest_chain = current_smallest
            end
            break
        else
            if current < current_smallest
                current_smallest = current
            end
            push!(current_chain, current)
        end
    end
end

println("Longest amicable chain length: $longest_chain_length starting with number: $longest_chain_starting_number with smallest member: $smallest_member_of_longest_chain")