# How many distinct arrangements of the two cubes allow for all of the square numbers to be displayed?

function add_interchangeable_digits(combination::Vector{Int})
    if 6 in combination && !(9 in combination)
        push!(combination, 9)
    elseif 9 in combination && !(6 in combination)
        push!(combination, 6)
    end
    return combination
end

function is_cube_digit_pair(combination1::Vector{Int}, combination2::Vector{Int})
    required_values = [1,4,9,16,25,36,49,64,81]
    found_values = []
    interchangeable_combination1 = deepcopy(combination1)
    interchangeable_combination2 = deepcopy(combination2)
    interchangeable_combination1 = add_interchangeable_digits(interchangeable_combination1)
    interchangeable_combination2 = add_interchangeable_digits(interchangeable_combination2)

    for digit1 in interchangeable_combination1
        for digit2 in interchangeable_combination2
            value12 = 10*digit1 + digit2
            value21 = 10*digit2 + digit1
            if value12 in required_values && !(value12 in found_values)
                push!(found_values, value12)
            end
            if value21 in required_values && !(value21 in found_values)
                push!(found_values, value21)
            end
        end

        if length(found_values) == length(required_values)
            return true
        end
    end

    return false
end

all_combinations = []
for i in 0:9
    for j in i+1:9
        for k in j+1:9
            for l in k+1:9
                for m in l+1:9
                    for n in m+1:9
                        push!(all_combinations, [i, j, k, l, m, n])
                    end
                end
            end
        end
    end
end

number_of_combinations = length(all_combinations)
valid_combinations = []
for i in 1:number_of_combinations
    for j = i+1:number_of_combinations
        combination1 = all_combinations[i]
        combination2 = all_combinations[j]
        if is_cube_digit_pair(combination1, combination2)
            push!(valid_combinations, [combination1, combination2])
        end
    end
end

println("Valid combinations: $(length(valid_combinations))")