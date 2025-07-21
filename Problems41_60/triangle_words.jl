# Find number of triangle words in a file

function is_triangle_number(n)
    iterator = 1
    current_triangle_number = 0
    while current_triangle_number < n
        current_triangle_number = 0.5*iterator*(iterator+1)
        iterator += 1

        if current_triangle_number == n
            return true
        end
    end

    return false
end

function encode_name(name)
    score = 0
    for char in name
        score += char - 'A' + 1
    end
    return score
end

file_contents = strip(read(joinpath(@__DIR__, "0042_words.txt"), String), '"')
names = split(file_contents, "\",\"")

triangle_number_words = 0
for i in eachindex(names)
    name_score = encode_name(names[i])
    if is_triangle_number(name_score)
        global triangle_number_words += 1
    end
end

println("The number of triangle words is: ", triangle_number_words)