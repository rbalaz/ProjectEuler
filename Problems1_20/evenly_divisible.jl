# Smallest possible number that is evenly divisible by all numbers from 1 to 20

function is_evenly_divisible(n)
    for i in 1:20
        if n % i != 0
            return false
        end
    end
    return true
end

n = 20
while is_evenly_divisible(n) == false
    global n += 20
end

println(n)