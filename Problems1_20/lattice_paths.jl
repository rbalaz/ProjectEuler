# Calculate routes in an 20x20 grid from top left to bottom right corner by moving only right and down.

using Printf

# Each path is a permutation of n right and n down moves
function lattice_paths(n)    
    range = n+1:2n
    first_product = BigInt(1)
    for i in range
        first_product *= BigInt(i)
    end
    range = 1:n
    second_product = BigInt(1)
    for i in range
        second_product *= BigInt(i)
    end
    return first_product/second_product
end

lattice_two = lattice_paths(2)
println("Lattice paths for 2x2 grid: " * string(lattice_two))
lattice_three = lattice_paths(3)
println("Lattice paths for 3x3 grid: " * string(lattice_three))
lattice_twenty = lattice_paths(20)
@printf("Lattice paths for 20x20 grid: %d\n", lattice_twenty)