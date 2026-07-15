# Find the last ten digits of '28433 * 2^7830457 + 1' non-Mersenne prime

starting_point = BigInt(28433)
println(starting_point)
for i in 1:7830457
    global starting_point *= 2
    # We only care about the last ten digits
    # If number exceeds ten digits, strip the extra digits away
    if starting_point > 10^10
        starting_point = starting_point % 10^10
    end
end

starting_point += 1
println(starting_point)