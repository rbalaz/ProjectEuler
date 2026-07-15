# How many triangles with integer coordinates and a right angle at the origin are there with the other two vertices in the first quadrant and with coordinates less than or equal to 50?

function distance_between_points(x1, y1, x2, y2)
    return sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function is_right_angled_triangle(a, b, c)
    sides = sort([a, b, c])
    equality_with_tolerance = sides[3]^2 - (sides[1]^2 + sides[2]^2)
    return abs(equality_with_tolerance) < 1e-6
end

upper_limit = 50
right_angled_triangles_count = 0

for x1 = 0:upper_limit
    for y1 = 0:upper_limit
        if x1 ==0 && y1 == 0
            continue
        end
        for x2 = 0:upper_limit
            for y2 = 0:upper_limit
                if x2 == 0 && y2 == 0
                    continue
                end

                if x1 == x2 && y1 == y2
                    continue
                end

                a = distance_between_points(0, 0, x1, y1)
                b = distance_between_points(0, 0, x2, y2)
                c = distance_between_points(x1, y1, x2, y2)
                if is_right_angled_triangle(a, b, c)
                    global right_angled_triangles_count += 1
                end
            end
        end
    end
end

# Results are duplicated because of the order of points, so we divide by 2 to get the correct count
# This is faster than checking for duplicates in the loop
right_angled_triangles_count = right_angled_triangles_count ÷ 2

println("Number of right angled triangles: $right_angled_triangles_count")