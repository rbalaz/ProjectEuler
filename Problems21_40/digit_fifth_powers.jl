# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

sum = 0
for i=2:9^5*6
    digits = collect(string(i))
    digit_sum = 0
    for digit in digits
        digit_sum += parse(Int, digit)^5
    end
    if digit_sum == i
        global sum += i
        println(i)
    end
end

println("The sum of all the numbers that can be written as the sum of fifth powers of their digits is: ", sum)