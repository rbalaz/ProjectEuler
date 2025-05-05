# Find perimeter of right angle triangles less or equal to 100 for which integral length sides solutions are maximized

function is_right_triangle(a,b,c)
    largest = max(a,b,c)
    if largest == a
        return a^2 == b^2 + c^2
    elseif largest == b
        return b^2 == a^2 + c^2
    else
        return c^2 == a^2 + b^2
    end
end

maximum_solution_count = 0
perimeter = 0
for i=12:1000
    solutions = []
    for j=1:i-2
        for k=1:i-1-j
            l = i - j - k
            if is_right_triangle(j,k,l)
                solutions_array = sort!([j,k,l])
                if !in(solutions_array, solutions)
                    push!(solutions, solutions_array)
                end
            end
        end
    end

    solution_count = size(solutions, 1)
    if solution_count > maximum_solution_count
        global maximum_solution_count = solution_count
        global perimeter = i
    end
end

println("Maximum Solution Count: $maximum_solution_count, Perimeter: $perimeter")