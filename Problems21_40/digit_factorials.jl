# Find the sum of all numbers which are equal to the sum of the factorial of their digits.

curious_numbers = []
for i=3:9999999
    string_number = string(i)
    sum_of_factorials = 0
    for string_digit in string_number
        digit = parse(Int, string_digit)
        sum_of_factorials += factorial(digit)
    end
    if sum_of_factorials == i
        push!(curious_numbers, i)
    end
end
println("The curious numbers are: ", curious_numbers)
println("The sum of all numbers which are equal to the sum of the factorial of their digits is: ", sum(curious_numbers))