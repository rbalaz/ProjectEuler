# What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2,...,n) where n > 1?

function pandigital_multiplication(number)
    concatenated_product = ""
    for i = 1:9
        concatenated_product *= string(number * i)
        if length(concatenated_product) >= 9
            break
        end
    end
    return concatenated_product
end

function is_pandigital(number_string)
    if length(number_string) != 9
        return false
    end
    for i=1:9
        if !occursin(string(i), number_string)
            return false
        end
    end

    return true
end

largest_concatenated_product = 0
for i=1:9999
    pandigital_string = pandigital_multiplication(i)
    if is_pandigital(pandigital_string) && parse(Int, pandigital_string) > largest_concatenated_product
        println("Found pandigital number: ", pandigital_string, " for i: ", i)
        global largest_concatenated_product = parse(Int, pandigital_string)
    end
end

println("Largest 1 to 9 pandigital 9-digit number: ", largest_concatenated_product)