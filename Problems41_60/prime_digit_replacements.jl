# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.

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

function combinations_of_set(set_size)
    combinations = []
    for i=1:set_size
        current_combination = []
        remaining_values = collect(1:set_size)
        append_value(current_combination, remaining_values, i, combinations)
    end

    return combinations
end

function append_value(current_combination, remaining_values, rank, combinations)
    for i in eachindex(remaining_values)
        new_combination = copy(current_combination)
        push!(new_combination, remaining_values[i])
        if length(new_combination) == rank
            push!(combinations, new_combination)
        else
            new_remaining_values = copy(remaining_values)
            new_remaining_values = remaining_values[i+1:end]
            append_value(new_combination, new_remaining_values, rank, combinations)
        end
    end
end

function validate_replacement(prime_string, combination)
    digits = []
    for i in eachindex(combination)
        push!(digits, prime_string[Int(combination[i])])
    end
    return length(unique(digits)) == 1
end

function prime_digit_replacement(prime, combinations)
    prime_string = string(prime)
    
    largest_prime_family = []

    for i in eachindex(combinations)
        if !(validate_replacement(prime_string, combinations[i]))
            continue
        end
        
        prime_number_family = []
        for j=0:9
            if (j == 0 && 1 in combinations[i])
                continue  # Skip leading zero replacements
            end
            replaced_prime = prime_string
            for k in eachindex(combinations[i])
                replaced_prime = replace_at_index(replaced_prime, Int(combinations[i][k]), string(j)[1])
            end
            replaced_prime_value = parse(Int, replaced_prime)
            if is_prime(replaced_prime_value)
                push!(prime_number_family, replaced_prime_value)
            end
        end
        if length(prime_number_family) > length(largest_prime_family)
            largest_prime_family = prime_number_family
        end
    end

    return largest_prime_family
end

function replace_at_index(str, index, replacement)
    str_array = collect(str)
    str_array[index] = replacement
    return join(str_array)
end

current_value = 0
family_size = 8
combinations_set = []
current_combination_set_size = 0
smallest_prime_family_number = 2^32 - 1

while true
    global current_value += 1
    number_of_digits = floor(log10(current_value) + 1)
    if number_of_digits > current_combination_set_size
        global current_combination_set_size = number_of_digits
        global combinations_set = combinations_of_set(number_of_digits)
    end
    if is_prime(current_value)
        prime_number_family = prime_digit_replacement(current_value, combinations_set)
        if length(prime_number_family) >= family_size
            if smallest_prime_family_number > current_value
                global smallest_prime_family_number = current_value
            end
        end
    end
    if smallest_prime_family_number < 2^32 - 1
        string_smallest = string(smallest_prime_family_number)
        string_current = string(current_value)
        if string_smallest[1] != string_current[1]
            break
        end
    end
end

println("Smallest prime with an eight prime value family: ", smallest_prime_family_number)