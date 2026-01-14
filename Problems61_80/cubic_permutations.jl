# Find the smallest cube for which exactly five permutations of its digits are cube

function is_permutation(a, b)
    return sort(collect(string(a))) == sort(collect(string(b)))
end

exponent = 1
iterator = 1
permutations_count = 5
while true
    relevant_cubes = []
    relevant_cube_strings = []
    while true
        cube = iterator^3
        if cube < 10^exponent
            global iterator += 1
            push!(relevant_cubes, cube)
            ordered_string = sort((collect(string(cube))))
            push!(relevant_cube_strings, join(ordered_string, ""))
            continue
        end
        break
    end

    permutations_candidate = ""
    for s in relevant_cube_strings
        if count(x -> x == s, relevant_cube_strings) == permutations_count
            permutations_candidate = s
            break
        end
    end
    if permutations_candidate == ""
        global exponent += 1
        continue
    end
    # Find first index of the [permutations_count] permutations
    first_index = findfirst(x -> x == permutations_candidate, relevant_cube_strings)
    println("The first cube with $permutations_count permutations is: ", relevant_cubes[first_index])
    break
end