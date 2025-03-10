# What is the total of all the name scores in the file?

file_contents = strip(read("C:\\ProjectEuler\\Problems21_40\\0022_names.txt", String), '"')
names = split(file_contents, "\",\"")
sorted_names = sort(names)
totalScore = 0
for (i, value) in enumerate(sorted_names)
    nameScore = 0
    for c in value
        nameScore += c - 'A' + 1
    end
    nameScore *= i
    if i == 938
        println("Name: ", value, " Score: ", nameScore)
    end
    global totalScore += nameScore
end

println("Total of all the name scores in the file: ", totalScore)