# Find integer right triangles with exactly one integer solution for wire lengths up to 1,500,000

limit = 1_500_000
wire_lengths = zeros(Int, limit)
# Euclid's formula for generating Pythagorean triples
for m=2:limit
    for n=1:m-1
        # n and m must be co-prime and exactly one of them is even
        if gcd(m,n) != 1 || (m - n) % 2 == 0
            continue
        end
        a = m^2 - n^2
        b = 2*m*n
        c = m^2 + n^2
        wire_length = a + b + c
        if wire_length > limit
            break
        end
        coefficient = 1
        while coefficient * wire_length <= limit
            wire_lengths[coefficient * wire_length] += 1
            coefficient += 1
        end
    end
end

single_solution_count = count(==(1), wire_lengths)
println("Number of wire lengths ≤ $limit that can form exactly one integer right triangle: $single_solution_count")