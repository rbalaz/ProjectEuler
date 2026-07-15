# Find the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, 
# can be obtained by inserting the operators +, -, *, / and brackets in any order between the digits.

function is_integer_and_non_negative(x)
    if x <= 0
        return false
    end
    
    delta = abs(x - round(x)) # Round to the nearest integer to handle floating point precision issues
    return delta < 1e-10
end

function longest_consecutive_sequence_list(results)
    sorted_results = sort(collect(results))
    longest_length = 0
    current_length = 1
    for i in eachindex(sorted_results)[2:end]
        if sorted_results[i] == sorted_results[i-1] + 1
            current_length += 1
        else
            longest_length = max(longest_length, current_length)
            current_length = 1
        end
    end
    
    longest_length = max(longest_length, current_length)
    return longest_length
end

function generate_permutations(a,b,c,d)
    numbers = [a, b, c, d]
    permutations = []
    for i in 1:4
        for j in 1:4
            if i == j
                continue
            end
            for k in 1:4
                if k == i || k == j
                    continue
                end
                for l in 1:4
                    if l == i || l == j || l == k
                        continue
                    end
                    push!(permutations, [numbers[i], numbers[j], numbers[k], numbers[l]])
                end
            end
        end
    end

    return permutations
end

function apply_operator(a, b, operator)
    if operator == 1
        return a + b
    elseif operator == 2
        return a - b
    elseif operator == 3
        return a * b
    elseif operator == 4
        return a / b
    else
        error("Invalid operator: ", operator)
    end
end

function evaluate_all_forms(a, b, c, d, o1, o2, o3)
    results = Set{Float64}()
    # 1: (A o1 B) o2 (C o3 D)
    first = apply_operator(a, b, o1)
    second = apply_operator(c, d, o3)
    result = apply_operator(first, second, o2)
    push!(results, result)
    # 2: ((A o1 B) o2 C) o3 D
    second = apply_operator(first, c, o2)
    result = apply_operator(second, d, o3)
    push!(results, result)
    # 3: (A o1 (B o2 C)) o3 D
    first = apply_operator(b, c, o2)
    second = apply_operator(a, first, o1)
    result = apply_operator(second, d, o3)
    push!(results, result)
    # 4: A o1 ((B o2 C) o3 D)
    first = apply_operator(b, c, o2)
    second = apply_operator(first, d, o3)
    result = apply_operator(a, second, o1)
    push!(results, result)
    # 5: A o1 (B o2 (C o3 D))
    first = apply_operator(c, d, o3)
    second = apply_operator(b, first, o2)
    result = apply_operator(a, second, o1)
    push!(results, result)
    return results
end

longest_chain_length = 0
longest_chain_representation = ""

for a=1:9
    for b=a+1:9
        for c=b+1:9
            for d=c+1:9
                distinct_results = Set{Int}()
                for o1=1:4
                    for o2=1:4
                        for o3=1:4
                            permutations = generate_permutations(a, b, c, d)
                            for perm in permutations
                                results = evaluate_all_forms(perm[1], perm[2], perm[3], perm[4], o1, o2, o3)
                                for result in results
                                    if is_integer_and_non_negative(result)
                                        if result ∉ distinct_results
                                            push!(distinct_results, round(result))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                current_chain_length = longest_consecutive_sequence_list(distinct_results)
                if current_chain_length > longest_chain_length
                    global longest_chain_length = current_chain_length
                    global longest_chain_representation = string(a, b, c, d)
                end
            end
        end
    end
end

println("Longest chain length: ", longest_chain_length)
println("Longest chain representation: ", longest_chain_representation)