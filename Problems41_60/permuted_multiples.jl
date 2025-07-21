# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x are permutations of the digits of x.

function is_permutation(a, b)
    return sort(collect(string(a))) == sort(collect(string(b)))
end

current_number = 1
while true
    violation_found = false
    for i=2:6
        multiple = current_number * i
        if !is_permutation(current_number, multiple)
            violation_found = true
            break
        end
    end

    if !violation_found
        println("The smallest positive integer x such that 2x, 3x, 4x, 5x, and 6x are permutations of the digits of x is: ", current_number)
        break
    end

    global current_number += 1
end