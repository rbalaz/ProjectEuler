# Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

function is_prime(n::Int)
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

const prime_cache = Dict{Int, Bool}()

function is_prime_cached(n::Int)
    if haskey(prime_cache, n)
        return prime_cache[n]
    end
    
    result = is_prime(n)
    prime_cache[n] = result
    return result
end

function is_prime_pair(first, second)
    first_second = parse(Int, string(first) * string(second))
    second_first = parse(Int, string(second) * string(first))
    return is_prime_cached(first_second) && is_prime_cached(second_first)
end

function is_prime_pair_set(primes)
    for (i, prime) in enumerate(primes)
        for j in (i+1):length(primes)
            if !is_prime_pair(prime, primes[j])
                return false
            end
        end
    end

    return true
end

function prime_pair_iteration_early_stop(primes, prime_sets, target_size)
    higher_prime_pair_sets = []
    
    for set in prime_sets
        max_value = maximum(set)
        starting_index = findfirst(primes .== max_value) + 1
        
        for prime in primes[starting_index:end]
            if prime in set
                continue
            end
            
            new_prime_set = [set..., prime]

            if is_prime_pair_set(new_prime_set)
                push!(higher_prime_pair_sets, new_prime_set)
                if length(new_prime_set) == target_size
                    return higher_prime_pair_sets
                end
            end
        end
    end

    return higher_prime_pair_sets
end

function sieve_of_eratosthenes(limit::Int)
    is_prime = fill(true, limit)
    is_prime[1] = false
    if limit >= 2
        is_prime[2] = true
    end
    
    for i in 2:floor(Int, sqrt(limit))
        if is_prime[i]
            for j in i*i:i:limit
                is_prime[j] = false
            end
        end
    end
    
    return [i for i in 2:limit if is_prime[i]]
end

primes = sieve_of_eratosthenes(12000)

prime_pairs_sets_two = []
for (i, prime) in enumerate(primes)
    for j in (i+1):length(primes)
        if is_prime_pair(prime, primes[j])
            push!(prime_pairs_sets_two, [prime, primes[j]])
        end
    end
end
println("Generated ", length(prime_pairs_sets_two), " prime pairs.")

current_sets = prime_pairs_sets_two
target_size = 5

for size in 3:target_size
    println("Looking for prime pair sets of size $size...")
    global current_sets = prime_pair_iteration_early_stop(primes, current_sets, target_size)
    println("Generated ", length(current_sets), " prime pair sets of $size.")
    
    if size == target_size && !isempty(current_sets)
        lowest_sum_set = current_sets[1]
        println("Found prime pair set of $target_size: ", lowest_sum_set)
        println("Sum: ", sum(lowest_sum_set))
        break
    end
    
    if isempty(current_sets)
        println("No sets of size $size found, may need more primes.")
        break
    end
end