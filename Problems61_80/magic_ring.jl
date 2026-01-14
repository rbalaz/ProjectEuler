# What is the maximum 16-digit string for a "magic" 5-gon ring?
# A magic 5-gon ring is made up of 10 nodes, with the numbers 1 to 10 used exactly once each.
# Each line of the ring adds to the same total, and the solution is found by concatenating the node values.
valid_sets = []
for i=1:10
    for j=1:10
        if j == i
            continue
        end
        for k=1:10
            if k == i || k == j
                continue
            end
            for l=1:10
                if l == i || l == j || l == k
                    continue
                end
                for m=1:10
                    if m == i || m == j || m == k || m == l
                        continue
                    end
                    for n=1:10
                        if n == i || n == j || n == k || n == l || n == m
                            continue
                        end
                        for o=1:10
                            if o == i || o == j || o == k || o == l || o == m || o == n
                                continue
                            end
                            first_gong = i + n + o
                            for p=1:10
                                if p == i || p == j || p == k || p == l || p == m || p == n || p == o
                                    continue
                                end
                                second_gong = j + o + p
                                if first_gong != second_gong
                                    continue
                                end
                                for q=1:10
                                    if q == i || q == j || q == k || q == l || q == m || q == n || q == o || q == p
                                        continue
                                    end
                                    third_gong = k + p + q
                                    if first_gong != third_gong
                                        continue
                                    end
                                    for r=1:10
                                        if r == i || r == j || r == k || r == l || r == m || r == n || r == o || r == p || r == q
                                            continue
                                        end
                                        fourth_gong = l + q + r
                                        if first_gong != fourth_gong
                                            continue
                                        end
                                        fifth_gong = m + r + n
                                        if first_gong == fifth_gong
                                            values = [i, j, k, l, m, n, o, p, q, r]
                                            push!(valid_sets, values)
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

maximum_gong_value = 0
gong_configuration = []
for valid_set in valid_sets
    first_index = argmin(valid_set[1:5])
    second_index = first_index + 5
    third_index = second_index + 1
    if third_index == 11
        third_index = 6
    end
    final_representation = string(valid_set[first_index]) * string(valid_set[second_index]) * string(valid_set[third_index])
    for i=1:4
        first_index += 1
        if first_index == 6
            first_index = 1
        end
        second_index += 1
        if second_index == 11
            second_index = 6
        end
        third_index += 1
        if third_index == 11
            third_index = 6
        end
        final_representation *= string(valid_set[first_index]) * string(valid_set[second_index]) * string(valid_set[third_index])
    end

    if length(final_representation) == 16
        final_value = parse(Int, final_representation)
        if final_value > maximum_gong_value
            global gong_configuration = valid_set
            global maximum_gong_value = final_value
        end
    end
end

println("Maximum 16-digit string for a magic 5-gon ring is: ", maximum_gong_value)
println("Gong configuration: ", gong_configuration)