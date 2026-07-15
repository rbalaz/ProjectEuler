# What is the largest square number formed by any member of a pair of anagramic squares?

# Step 1: Parse the file to get words
path = joinpath(@__DIR__, "0098_words.txt")
# Read the file and parse the words in comma separated format in a list
# File contains only a single line of text
raw_words = read(path, String)
words = split(raw_words, ",")
words = [strip(word, '"') for word in words]

# Step 2: Create a dictionary of anagrams
# Each anagram chain will be represented as a key-value pair in the dictionary, 
# where the key is the sorted version of the word and the value is a list of words that are anagrams of each other
anagrams = Dict{String, Vector{String}}()
longest_word_length = 0
for word in words
    sorted_word = String(sort(collect(string(word))))
    if haskey(anagrams, sorted_word)
        push!(anagrams[sorted_word], word)
    else
        anagrams[sorted_word] = [word]
    end
    global longest_word_length = max(longest_word_length, length(word))
end
# At the end, words that do not have any anagrams shall be pruned from the dictionary
filter!(x -> length(x[2]) > 1, anagrams)

# Step 3: Create a list of squares
limit = 10^longest_word_length
squares = []
for i in 1:floor(Int, sqrt(limit))
    push!(squares, i^2)
end

# Step 4: Find the largest square that can be formed by an anagram pair
# Goal is to find the largest square, meaning we will start from the longest words first
sorted_anagrams = sort(collect(anagrams), by = x -> -length(x[2][1]))
largest_matched_square = 0
largest_matched_key_length = 0
for (sorted_key, anagram_list) in sorted_anagrams
    current_key_length = length(sorted_key)
    if largest_matched_square > 0 && current_key_length < largest_matched_key_length
        # Only stop when all anagrams of the current length have been checked when a match is already available
        println("Largest square found for anagram pair $(anagram_list): $(largest_matched_square)")
        break
    end

    relevant_squares = sort(filter(x -> length(string(x)) == length(sorted_key), squares), rev = true)
    println("Checking anagram with key $(sorted_key) and anagrams $(anagram_list)")
    list_length = length(anagram_list)
    for i in 1:list_length-1
        for j in i+1:list_length
            first_anagram = anagram_list[i]
            second_anagram = anagram_list[j]
            for k in eachindex(relevant_squares)
                # Map digits of the square to letters of the first anagram
                digit_to_letter = Dict{Char, Char}()
                square_str = string(relevant_squares[k])
                is_square_valid = true
                for l in eachindex(first_anagram)
                    # Ensure that the mapping is consistent and that no two letters map to the same digit
                    if haskey(digit_to_letter, square_str[l])
                        if digit_to_letter[square_str[l]] != first_anagram[l]
                            is_square_valid = false
                            break
                        end
                    else
                        if first_anagram[l] in values(digit_to_letter)
                            is_square_valid = false
                            break
                        end
                    end
                    digit_to_letter[square_str[l]] = first_anagram[l]
                end
                if !is_square_valid
                    continue
                end
                # Check digits of the second anagram to see if they form a valid square
                second_anagram_digits = []
                for l in eachindex(second_anagram)
                    # Get the corresponding digit for the second anagram letter
                    digit = first(filter(x -> x[2] == second_anagram[l], collect(digit_to_letter)))[1]
                    push!(second_anagram_digits, digit)
                end
                second_anagram_square = parse(Int, join(second_anagram_digits))
                if second_anagram_square in relevant_squares
                    larger_square = max(relevant_squares[k], second_anagram_square)
                    if larger_square > largest_matched_square
                        global largest_matched_key_length = length(sorted_key)
                        global largest_matched_square = larger_square
                        println("New largest square found for anagram pair $(anagram_list): $(largest_matched_square)")
                    end
                end
            end
        end
    end
end