# Find the sum of the digits in the number 100!

function factorial_digit_sum(n)
    factorial_result = factorial(big(n))
    sum = 0
    for i in string(factorial_result)
        sum += parse(Int, i)
    end
    return sum
end

println("Sum of digits in 10! is: ", factorial_digit_sum(10))
println("Sum of digits in 100! is: ", factorial_digit_sum(100))