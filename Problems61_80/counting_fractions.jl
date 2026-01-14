# Counting the number of reduced proper fractions for d ≤ 1,000,000

function compute_totients(limit)
    phi = collect(1:limit)
    phi[1] = 1
    for i in 2:limit
        if phi[i] == i  # i is prime
            for j in i:i:limit
                phi[j] -= phi[j] ÷ i
            end
        end
    end
    return phi
end

limit = 1_000_000
phi = compute_totients(limit)

all_fractions_count = sum(phi[2:limit])

println("Total number of reduced proper fractions for d ≤ $limit is $all_fractions_count")