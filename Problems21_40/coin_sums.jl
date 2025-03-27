# How many different ways can £2 be made using any number of coins (1p, 2p, 5p, 10p, 20p, 50p, £1, £2)?

number_of_combinations = 0
for i=0:200
    for j = 0:100
        for k = 0:40
            for l = 0:20
                for m = 0:10
                    for n = 0:4
                        for o = 0:2
                            for p = 0:1
                                if 1*i + 2*j + 5*k + 10*l + 20*m + 50*n + 100*o + 200*p == 200
                                    global number_of_combinations += 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

println("The number of different ways £2 can be made using any number of coins is: ", number_of_combinations)