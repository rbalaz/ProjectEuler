# Find all 0 to 9 pandigital numbers that satisfy the sub-divisibility property and calculates their sum.

function pandigital_number_generator(pandigital_number_string, divisibility_pandigital_numbers)
    if length(pandigital_number_string) == 10
        if check_divisibility(pandigital_number_string)
            println("Found divisible pandigital number: ", pandigital_number_string)
            pandigital_number = parse(Int, pandigital_number_string)
            push!(divisibility_pandigital_numbers, pandigital_number)
            return
        end
    end
    iterator_start = 0
    if length(pandigital_number_string) == 0
        iterator_start = 1
    end
    for i=iterator_start:9
        if !contains(pandigital_number_string, string(i))
            new_pandigital_number_string = pandigital_number_string * string(i)
            pandigital_number_generator(new_pandigital_number_string, divisibility_pandigital_numbers)
        end
    end
end

function check_divisibility(pandigital_number_string)
    first_condition_value = parse(Int, pandigital_number_string[2:4])
    if first_condition_value % 2 != 0
        return false
    end
    second_condition_value = parse(Int, pandigital_number_string[3:5])
    if second_condition_value % 3 != 0
        return false
    end
    third_condition_value = parse(Int, pandigital_number_string[4:6])
    if third_condition_value % 5 != 0
        return false
    end
    fourth_condition_value = parse(Int, pandigital_number_string[5:7])
    if fourth_condition_value % 7 != 0
        return false
    end
    fifth_condition_value = parse(Int, pandigital_number_string[6:8])
    if fifth_condition_value % 11 != 0
        return false
    end
    sixth_condition_value = parse(Int, pandigital_number_string[7:9])
    if sixth_condition_value % 13 != 0
        return false
    end
    seventh_condition_value = parse(Int, pandigital_number_string[8:10])
    return seventh_condition_value % 17 == 0
end

divisibility_pandigital_numbers = []
pandigital_number_generator("", divisibility_pandigital_numbers)
println("The sum of all 0 to 9 pandigital numbers with given sub-divisibility property is: ", sum(divisibility_pandigital_numbers))