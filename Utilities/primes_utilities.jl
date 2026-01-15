module PrimeUtilities

export is_prime, generate_primes_up_to

function is_prime(n)
    if n <= 1
        return false
    end
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end

function generate_primes_up_to(limit)
    primes = Int[]
    for i in 2:limit
        if is_prime(i)
            push!(primes, i)
        end
    end

    return primes
end

end