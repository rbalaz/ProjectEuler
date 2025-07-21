# Using 0059_cipher.txt, a file containing the encrypted ASCII codes, and the knowledge that the plain text must contain common English words, 
# decrypt the message and find the sum of the ASCII values in the original text. A modern encryption method is to take a text file, convert 
# the bytes to ASCII, then XOR each byte with a given value, taken from a secret key.

lines = readlines(joinpath(@__DIR__, "0059_cipher.txt"))
encrypted_text = parse.(Int, split(lines[1], ","))
starting_index = codepoint('a')
ending_index = codepoint('z')

decrypted = false
for i=starting_index:ending_index
    for j=starting_index:ending_index
        for k=starting_index:ending_index
            key = [i, j, k]

            decrypted_text = []
            sum_of_ascii_values = 0
            for (l, value) in enumerate(encrypted_text)
                decrypted_value = xor(encrypted_text[l], key[(l-1) % 3 + 1])
                sum_of_ascii_values += decrypted_value
                decrypted_char = Char(decrypted_value)
                push!(decrypted_text, decrypted_char)
            end

            decrypted_string = join(decrypted_text)
            if occursin(" the ", decrypted_string) && occursin(" and ", decrypted_string) && occursin(" to ", decrypted_string)
                println("Key: ", Char(i), Char(j), Char(k))
                println("Decrypted Text: ", decrypted_string)
                println("Sum of ASCII values: ", sum_of_ascii_values)
                global decrypted = true
                break
            end
        end
    end
    if decrypted
        break
    end
end