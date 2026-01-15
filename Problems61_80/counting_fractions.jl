# Counting the number of reduced proper fractions for d ≤ 1,000,000

include("../Utilities/totient_utilities.jl")
using .TotientUtlities

limit = 1_000_000
phi = compute_totients(limit)

all_fractions_count = sum(phi[2:limit])

println("Total number of reduced proper fractions for d ≤ $limit is $all_fractions_count")