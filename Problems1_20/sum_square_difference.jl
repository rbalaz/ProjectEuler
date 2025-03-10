# Difference between sum of squares and square of sum of first 100 natural numbers

function sum_square_difference(n)
    sum_of_squares = sum([i^2 for i in 1:n])
    square_of_sum = sum(1:n)^2
    return square_of_sum - sum_of_squares
end

println(sum_square_difference(100))