# What is the first value which can be written as the sum of primes in over five thousand different ways?

function generate_primes_up_to(limit)
    primes = Int[]
    for i in 2:limit
        if is_prime(i)
            push!(primes, i)
        end
    end

    return primes
end

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

function calculate_combinations(current_combination, combinations, primes, primes_index, limit)
    current_primes_index = primes_index
    while true
        current_combination_clone = copy(current_combination)
        push!(current_combination_clone, primes[current_primes_index])
        current_sum = sum(current_combination_clone)
        if current_sum == limit && !(current_combination_clone in combinations)
            push!(combinations, copy(current_combination_clone))
        elseif current_sum < limit - 1 # 2 is the smallest prime
            calculate_combinations(current_combination_clone, combinations, primes, current_primes_index, limit)
        end
        current_primes_index -= 1
        if current_primes_index == 0
            break
        end
    end
end

limit = 5000
primes = generate_primes_up_to(limit)
first_combination_over_5000 = 0
number_of_combinations = 0
for i=2:limit
    # Slice primes up to i
    relevant_primes = filter(x -> x < i, primes)
    combinations = Set{Vector{Int}}()
    for j=length(relevant_primes):-1:1
        current_combination = [relevant_primes[j]]
        calculate_combinations(current_combination, combinations, relevant_primes, j, i)
    end

    if length(combinations) > 5000
        global first_combination_over_5000 = i
        global number_of_combinations = length(combinations)
        break
    end
end

limit = 10
println("First value with number of prime combinations over 5000 is ", first_combination_over_5000, " with ", number_of_combinations, " combinations.")