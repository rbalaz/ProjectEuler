#=
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6, and 9.
The sum of these multiples is 23. Find the sum of all multiple of 3 and 5 below 1000.
=#

function MultiplesOfNumber(x, upperBoundary)
    multiples = []
    for i in 1:upperBoundary-1
        if i % x == 0
            push!(multiples, i)
        end
    end
    return multiples
end

multiples_of_3 = MultiplesOfNumber(3, 1000)
multiples_of_5 = MultiplesOfNumber(5, 1000)

union_multiples = union(multiples_of_3, multiples_of_5)
sum_of_multiples = sum(union_multiples)
println(sum_of_multiples)