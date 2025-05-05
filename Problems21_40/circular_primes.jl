# How many circular primes are there below one million?

function is_prime(n)
    if n < 2
        return false
    end
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end

function get_circular_transformations(n)
    circular_transformations = []
    string_number = string(n)
    for i in eachindex(string_number)
        transformed_number = string_number[i:end] * string_number[1:i-1]
        push!(circular_transformations, parse(Int, transformed_number))
    end

    return circular_transformations
end

function get_circular_primes(n)
    circular_primes = []
    for i=1:n
        circular_transformations = get_circular_transformations(i)
        is_circular_prime = true
        for transformation in circular_transformations
            if is_prime(transformation) == false
                is_circular_prime = false
                break
            end
        end
        if is_circular_prime
            for transformation in circular_transformations
                if !in(transformation, circular_primes)
                    push!(circular_primes, transformation)
                end
            end
        end
    end

    return circular_primes
end



println("Circular primes below one hundred: ", get_circular_primes(100))
println("Number of circular primes below one hundred: ", length(get_circular_primes(100)))
println("Circular primes below one thousand: ", get_circular_primes(1000))
println("Number of circular primes below one thousand: ", length(get_circular_primes(1000)))
println("Circular primes below one million: ", get_circular_primes(1000000))
println("Number of circular primes below one million: ", length(get_circular_primes(1000000)))