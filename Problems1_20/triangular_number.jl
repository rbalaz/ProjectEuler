# First triangular numbers to have over five hundred divisors

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

i = 1
while true
    triangular_number = sum(1:i)
    factors = get_factors(triangular_number)
    if length(factors) > 500
        println(triangular_number)
        break
    end
    global i += 1
end