# Find the product of the Pythagorean triplet for which a + b + c = 1000

using Printf

function pyth_triplet()
    for i = 1:1000
        for j = 1:1000
            k = sqrt(i*i + j*j)
            if(isinteger(k) && i+j+k == 1000)
                return i*j*k
            end
        end
    end
end

@printf("The product of the Pythagorean triplet is: %d\n", pyth_triplet())