# How many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?

include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

function generate_powers(primes, power, limit)
    powers = []
    for prime in primes
        p_power = prime^power
        if p_power > limit
            break
        end
        push!(powers, p_power)
    end
    return powers
end

limit = floor(Int, sqrt(50_000_000))
primes = generate_primes_up_to(limit)
squares = generate_powers(primes, 2, 50_000_000)
cubes = generate_powers(primes, 3, 50_000_000)
fourths = generate_powers(primes, 4, 50_000_000)

representable_numbers = Set{Int}()
for square in squares
    for cube in cubes
        if square + cube >= 50_000_000
            break
        end
        for fourth in fourths
            sum = square + cube + fourth
            if sum < 50_000_000 && !(sum in representable_numbers)
                push!(representable_numbers, sum)
            end
        end
    end
end

println("Number of representable numbers: ", length(representable_numbers))