# Find the sum of the only ordered set of six cyclic 4-digit numbers for which each polygonal type: 
# triangle, square, pentagonal, hexagonal, heptagonal, and octagonal, is represented by a different number in the set.

function is_cyclic(first, second)
    string_first = string(first)
    string_second = string(second)
    return string_first[3:end] == string_second[1:2]
end

function validate_cyclic_set(cyclic_set, four_digit_triangle_numbers, four_digit_square_numbers,
                              four_digit_pentagonal_numbers, four_digit_hexagonal_numbers,
                              four_digit_heptagonal_numbers, four_digit_octagonal_numbers)
    
    reserved_numbers = []
    for value in cyclic_set
        if value in four_digit_triangle_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    if length(reserved_numbers) == 0
        return false
    end
    for value in cyclic_set
        if value in reserved_numbers
            continue
        end
        if value in four_digit_square_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    if length(reserved_numbers) == 1
        return false
    end
    for value in cyclic_set
        if value in reserved_numbers
            continue
        end
        if value in four_digit_pentagonal_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    if length(reserved_numbers) == 2
        return false
    end
    for value in cyclic_set
        if value in reserved_numbers
            continue
        end
        if value in four_digit_hexagonal_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    if length(reserved_numbers) == 3
        return false
    end
    for value in cyclic_set
        if value in reserved_numbers
            continue
        end
        if value in four_digit_heptagonal_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    if length(reserved_numbers) == 4
        return false
    end
    for value in cyclic_set
        if value in reserved_numbers
            continue
        end
        if value in four_digit_octagonal_numbers
            push!(reserved_numbers, value)
            break
        end
    end
    return length(reserved_numbers) == 6
end

function find_cyclic_set(four_digit_triangle_numbers, four_digit_square_numbers,
                         four_digit_pentagonal_numbers, four_digit_hexagonal_numbers,
                         four_digit_heptagonal_numbers, four_digit_octagonal_numbers,
                         all_four_digit_numbers)
    for (i, first_number) in enumerate(all_four_digit_numbers)
        for j=i+1:length(all_four_digit_numbers)
            second_number = all_four_digit_numbers[j]
            if (is_cyclic(first_number, second_number))
                for (k, third_number) in enumerate(all_four_digit_numbers)
                    if k == i || k == j
                        continue
                    end
                    if (is_cyclic(second_number, third_number))
                        for (l, fourth_number) in enumerate(all_four_digit_numbers)
                            if l == i || l == j || l == k
                                continue
                            end

                            if (is_cyclic(third_number, fourth_number))
                                for (m, fifth_number) in enumerate(all_four_digit_numbers)
                                    if m == i || m == j || m == k || m == l
                                        continue
                                    end

                                    if (is_cyclic(fourth_number, fifth_number))
                                        for (n, sixth_number) in enumerate(all_four_digit_numbers)
                                            if n == i || n == j || n == k || n == l || n == m
                                                continue
                                            end

                                            if (is_cyclic(fifth_number, sixth_number) && is_cyclic(sixth_number, first_number))
                                                # Found a cyclic set of six numbers
                                                cyclic_set = [first_number, second_number, third_number, fourth_number, fifth_number, sixth_number]
                                                # Check if all types are represented
                                                if validate_cyclic_set(cyclic_set, four_digit_triangle_numbers, four_digit_square_numbers,
                                                                    four_digit_pentagonal_numbers, four_digit_hexagonal_numbers,
                                                                    four_digit_heptagonal_numbers, four_digit_octagonal_numbers)
                                                    println("Found cyclic set: ", cyclic_set)
                                                    return sum(cyclic_set)
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
        end
    end
end

all_four_digit_numbers = []
four_digit_triangle_numbers = []
n = 1
while true
    value = n * (n + 1) ÷ 2
    if value > 999 && value < 10000
        push!(four_digit_triangle_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

four_digit_square_numbers = []
n = 1
while true
    value = n * n
    if value > 999 && value < 10000
        push!(four_digit_square_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

four_digit_pentagonal_numbers = []
n = 1
while true
    value = n * (3 * n - 1) ÷ 2
    if value > 999 && value < 10000
        push!(four_digit_pentagonal_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

four_digit_hexagonal_numbers = []
n = 1
while true
    value = n * (2 * n - 1)
    if value > 999 && value < 10000
        push!(four_digit_hexagonal_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

four_digit_heptagonal_numbers = []
n = 1
while true
    value = n * (5 * n - 3) ÷ 2
    if value > 999 && value < 10000
        push!(four_digit_heptagonal_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

four_digit_octagonal_numbers = []
n = 1
while true
    value = n * (3 * n - 2)
    if value > 999 && value < 10000
        push!(four_digit_octagonal_numbers, value)
        push!(all_four_digit_numbers, value)
    elseif value >= 10000
        break
    end
    global n += 1
end

cyclic_sum = find_cyclic_set(four_digit_triangle_numbers, four_digit_square_numbers,
                              four_digit_pentagonal_numbers, four_digit_hexagonal_numbers,
                              four_digit_heptagonal_numbers, four_digit_octagonal_numbers,
                              all_four_digit_numbers)
println("The sum of the cyclic figurate numbers is: ", cyclic_sum)