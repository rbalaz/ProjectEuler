# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

function get_all_permutations(digits, current_candidate, permutations)
    if length(digits) == 1
        push!(permutations, current_candidate * string(digits[1]))
    end
    for i = 1:lastindex(digits)
        new_digits = copy(digits)
        get_all_permutations(deleteat!(new_digits, i), current_candidate * string(digits[i]), permutations)
    end
end

permutations = []
get_all_permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9],"", permutations)
permutations = sort(permutations)
println("Millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9 is: " * permutations[1000000])