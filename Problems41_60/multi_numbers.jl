# Find the next triangle number that is also pentagonal and hexagonal after 40755.

function generate_triangle_numbers(n)
    triangle_numbers = []
    for i = 1:n
        triangle_number = Int(i*(i + 1)/2)
        push!(triangle_numbers, triangle_number)
    end

    return triangle_numbers
end

function generate_pentagon_numbers(n)
    pentagon_numbers = []
    for i = 1:n
        pentagon_number = Int(i*(3*i - 1)/2)
        push!(pentagon_numbers, pentagon_number)
    end

    return pentagon_numbers
end

function generate_hexagonal_numbers(n)
    hexagonal_numbers = []
    for i = 1:n
        hexagonal_number = i*(2*i - 1)
        push!(hexagonal_numbers, hexagonal_number)
    end

    return hexagonal_numbers
end

numbers_count = 100000
triangle_numbers = generate_triangle_numbers(numbers_count)
pentagon_numbers = generate_pentagon_numbers(numbers_count)
hexagonal_numbers = generate_hexagonal_numbers(numbers_count)
multi_numbers = []
for i=1:numbers_count
    current_triangle_number = triangle_numbers[i]
    if current_triangle_number in pentagon_numbers && current_triangle_number in hexagonal_numbers
        push!(multi_numbers, current_triangle_number)
    end
end

for num in multi_numbers
    println("The number $num is triangular, pentagonal, and hexagonal at the same time.")
end