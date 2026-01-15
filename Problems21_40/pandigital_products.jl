# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

function is_pandigital(product, multiplicand, multiplier)
    concatenated_digits = string(product) * string(multiplicand) * string(multiplier)
    if length(concatenated_digits) != 9
        return false
    end
    for i in 1:9
        if !occursin(string(i), concatenated_digits)
            return false
        end
    end
    return true
end

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

products = []
for i = 1:9999
    factors = get_factors(i)
    for factor in factors
        if is_pandigital(i, factor, Int(i / factor)) == true
            if !in(i, products)
                push!(products, i)
            end
            break
        end
    end
end

println("The sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital is: ", sum(products))