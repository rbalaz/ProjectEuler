# Count the number of reduced proper fractions for d ≤ 12,000 between 1/3 and 1/2

limit = 12_000
valid_fraction_count = 0
lower_limit = 1/3
upper_limit = 1/2

for i = 2:limit
    numerator_limit = ceil(Int, (i / 2))
    for j = numerator_limit:-1:1
        if j/i > lower_limit && j/i < upper_limit && gcd(i,j) == 1
            global valid_fraction_count += 1
        elseif j/i <= lower_limit
            break
        end
    end
end

println("Count of all reduced proper fractions for d ≤ $limit between 1/3 and 1/2 is $valid_fraction_count")