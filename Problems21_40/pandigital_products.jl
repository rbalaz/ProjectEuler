# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

function all_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            push!(factors, Int(n / i))
        end
    end
    return factors
end

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

products = []
for i = 1:9999
    factors = all_factors(i)
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