# Find the pair of pentagon numbers, Pj and Pk, such that |Pk - Pj| is minimized and Pj + Pk is also pentagonal.

function generate_pentagon_number(n)
    return Int(n*(3*n - 1)/2)
end

function generate_pentagon_numbers(n)
    pentagon_numbers = []
    for i = 1:n
        push!(pentagon_numbers, generate_pentagon_number(i))
    end

    return pentagon_numbers
end

numbers_count = 10000
minimal_difference = 2^32 - 1
pentagon_numbers = generate_pentagon_numbers(numbers_count)
for i=1:numbers_count-1
    for j=1:numbers_count-i
        difference = abs(pentagon_numbers[j] - pentagon_numbers[j+i])
        if minimal_difference < difference
            break
        end
        sum = pentagon_numbers[j] + pentagon_numbers[j+i]
        if difference in pentagon_numbers && sum in pentagon_numbers && difference < minimal_difference
            println("Found pentagon numbers: ", pentagon_numbers[j], " and ", pentagon_numbers[j+i])
            global minimal_difference = difference
        end
    end
end

println("The minimal difference is: ", minimal_difference)