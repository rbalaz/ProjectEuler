# Largest palindrome from a product of two three digit numbers.

function largest_palindrome()
    largest_palindrome = -1
    for i in 100:999
        for j in 100:999
            product = i * j
            if is_palindrome(product) == true && product > largest_palindrome
                largest_palindrome = product
            end
        end
    end
    return largest_palindrome
end

include("../Utilities/combinatorics_utilities.jl")
using .CombinatoricsUtilities

println(largest_palindrome())