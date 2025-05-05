# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

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

function is_left_truncatable_prime(number_string, primes_list)
    for i in 1:length(number_string)
        if !(parse(Int, number_string[i:end]) in primes_list)
            return false
        end
    end

    return true
end

function is_right_truncatable_prime(number_string, primes_list)
    for i in 1:length(number_string)
        if !(parse(Int, number_string[1:i]) in primes_list)
            return false
        end
    end

    return true
end

truncatable_primes = []
primes_list = [2, 3, 5, 7]
current_value = 11
while length(truncatable_primes) < 11
    if !is_prime(current_value)
        current_value += 1
        continue
    end
    push!(primes_list, current_value)

    current_value_string = string(current_value)
    if is_left_truncatable_prime(current_value_string, primes_list) && is_right_truncatable_prime(current_value_string, primes_list)
        println("Found truncatable prime: ", current_value)
        push!(truncatable_primes, current_value)
    end
    global current_value += 1
end

println("Sum of the only eleven primes that are both truncatable from left to right and right to left: ", sum(truncatable_primes))