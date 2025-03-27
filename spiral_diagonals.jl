# Wha is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed by moving right in a clockwise direction.

function spiral_diagonal_sum(n)
    sum = 0
    for i::Int = 3:2:n
        sum += i*i + 3*(i-2)*(i-2) + 6*(i-1)
    end
    return sum + 1
end

println("The sum of the numbers on the diagonals in a 1001 by 1001 spiral formed by moving right in a clockwise direction is: ", spiral_diagonal_sum(1001))