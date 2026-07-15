# Find the sum of the perimeters of all almost equilateral triangles with integral side lengths and area and whose perimeters do not exceed one billion.

using Printf

function plain_number(value)
    if value isa AbstractFloat
        text = @sprintf("%.10f", value)
        text = replace(text, r"0+$" => "")
        return endswith(text, ".") ? text[1:end-1] : text
    end

    return string(value)
end

function triangles_pell_equation2(perimeter_limit)
    # Pell equation x^2-3y^2=1
    # Find integer solutions and then calculate corresponding triangles until perimeter exceeds limit
    x_current = BigInt(2)
    perimeter_sum = BigInt(0)
    resolved_positive = Set{BigInt}()
    resolved_negative = Set{BigInt}()
    while x_current < 10000
        if x_current in resolved_positive || x_current in resolved_negative
            x_current += 1
            continue
        end
        if (2*x_current + 1) % 3 == 0
            side_basis_positive = (2*x_current + 1) ÷ 3
            perimeter_positive = 3*side_basis_positive + 1
            if perimeter_positive > perimeter_limit
                break
            end
            area = 0.25 * sqrt((side_basis_positive^2 + side_basis_positive^2 + (side_basis_positive + 1)^2)^2 - 2*(side_basis_positive^4 + side_basis_positive^4 + (side_basis_positive + 1)^4))
            if abs(area - floor(area)) < 1e-10 && area > 0
                println("Found almost equilateral triangle with sides: $(plain_number(side_basis_positive)), $(plain_number(side_basis_positive)), $(plain_number(side_basis_positive + 1)) and area: $(plain_number(area))")
                perimeter_sum += perimeter_positive
                x_next = x_current
                y_next = sqrt((x_current^2 - 1) ÷ 3)
                alternation_coefficient = -1
                while true
                    x_next, y_next = next_pell_solution(x_next, y_next)
                    push!(resolved_positive, x_next)
                    side_next = (2*x_next + alternation_coefficient)/3
                    perimeter_next = 3*side_next + alternation_coefficient
                    if perimeter_next > perimeter_limit
                        break
                    end
                    area = 0.25 * sqrt((side_next^2 + side_next^2 + (side_next + alternation_coefficient)^2)^2 - 2*(side_next^4 + side_next^4 + (side_next + alternation_coefficient)^4))
                    println("Found next almost equilateral triangle with sides: $(plain_number(side_next)), $(plain_number(side_next)), $(plain_number(side_next + alternation_coefficient)) and area: $(plain_number(area))")
                    perimeter_sum += perimeter_next
                    alternation_coefficient *= -1
                end
            end
        end 
        if (2*x_current - 1) % 3 == 0
            side_basis_negative = (2*x_current - 1) ÷ 3
            perimeter_negative = 3*side_basis_negative - 1
            if perimeter_negative > perimeter_limit
                break
            end
            area = 0.25 * sqrt((side_basis_negative^2 + side_basis_negative^2 + (side_basis_negative - 1)^2)^2 - 2*(side_basis_negative^4 + side_basis_negative^4 + (side_basis_negative - 1)^4))
            if abs(area - floor(area)) < 1e-10 && area > 0
                println("Found almost equilateral triangle with sides: $(plain_number(side_basis_negative)), $(plain_number(side_basis_negative)), $(plain_number(side_basis_negative - 1)) and area: $(plain_number(area))")
                perimeter_sum += perimeter_negative
                x_next = x_current
                y_next = sqrt((x_current^2 - 1) ÷ 3)
                alternation_coefficient = 1
                while true
                    x_next, y_next = next_pell_solution(x_next, y_next)
                    push!(resolved_negative, x_next)
                    side_next = (2*x_next + alternation_coefficient)/3
                    perimeter_next = 3*side_next + alternation_coefficient
                    if perimeter_next > perimeter_limit
                        break
                    end
                    area = 0.25 * sqrt((side_next^2 + side_next^2 + (side_next + alternation_coefficient)^2)^2 - 2*(side_next^4 + side_next^4 + (side_next + alternation_coefficient)^4))
                    println("Found next almost equilateral triangle with sides: $(plain_number(side_next)), $(plain_number(side_next)), $(plain_number(side_next + alternation_coefficient)) and area: $(plain_number(area))")
                    perimeter_sum += perimeter_next
                    alternation_coefficient *= -1
                end
            end
        end
        x_current += 1
    end

    println("Perimeter sum: $(plain_number(perimeter_sum)) for perimeter limit: $(plain_number(perimeter_limit))")
end

function next_pell_solution(x_current, y_current)
    x_next = 2*x_current + 3*y_current
    y_next = x_current + 2*y_current
    return x_next, y_next
end

perimeter_limit = 1_000_000_000

triangles_pell_equation2(perimeter_limit)