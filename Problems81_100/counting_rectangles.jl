# Find the area of the grid with the nearest solution to two million rectangles.

function count_rectangles(m, n)
    rectangles_count = 0
    for i = 1:m
        for j = 1:n
            rectangles_count += i * j
        end
    end
    return rectangles_count
end

current_n = 2
current_m = 3
closest_approximation = count_rectangles(current_m, current_n)
closest_deviation = abs(closest_approximation - 2_000_000)
closest_area = current_m * current_n
first_iteration = true
while true
    global current_m += 1
    current_approximation = count_rectangles(current_m, current_n)
    current_deviation = abs(current_approximation - 2_000_000)
    if current_approximation > 2_000_000 && current_deviation > closest_deviation && first_iteration
        break
    end
    global first_iteration = false
    if current_deviation < closest_deviation
        global closest_approximation = current_approximation
        global closest_deviation = current_deviation
        global closest_area = current_m * current_n
    elseif current_approximation > 2_000_000
        global current_n += 1
        global current_m = 1
        global first_iteration = true
    end
end

println("Closest approximation: ", closest_approximation)
println("Closest area: ", closest_area)