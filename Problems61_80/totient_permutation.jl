# Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.

include("../Utilities/totient_utilities.jl")
using .TotientUtlities
include("../Utilities/combinatorics_utilities.jl")
using .CombinatoricsUtilities

limit = 10_000_000
phi = compute_totients(limit)
totient_permutation_minimum = Inf
min_n = 0
for n in 2:limit
    if is_permutation(n, phi[n])
        current_ratio = n / phi[n]
        if current_ratio < totient_permutation_minimum
            global totient_permutation_minimum = current_ratio
            global min_n = n
        end
    end
end

println("Final minimum ratio n/φ(n) = $totient_permutation_minimum at n = $min_n")