# Find largest prime pandigital number

function is_pandigital(number_string)
    for i=1:length(number_string)
        if !occursin(string(i), number_string)
            return false
        end
    end

    return true
end

include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

largest_pandigital_prime = 0
for i=1:999999999
    if is_pandigital(string(i)) && is_prime(i) && i > largest_pandigital_prime
        global largest_pandigital_prime = i
    end
end

println("The largest pandigital prime is: ", largest_pandigital_prime)