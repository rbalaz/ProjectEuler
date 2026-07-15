# Find the number of characters saved by writing each of the Roman numerals in their minimal form.

function reduce_to_minimal_form(roman_numeral)
    original_numeral = deepcopy(roman_numeral)
    roman_numeral = replace(roman_numeral, "VIIII" => "IX")
    roman_numeral = replace(roman_numeral, "IIII" => "IV")
    roman_numeral = replace(roman_numeral, "VV" => "X")
    roman_numeral = replace(roman_numeral, "LXXXX" => "XC")
    roman_numeral = replace(roman_numeral, "XXXX" => "XL")
    roman_numeral = replace(roman_numeral, "LL" => "C")
    roman_numeral = replace(roman_numeral, "DCCCC" => "CM")
    roman_numeral = replace(roman_numeral, "CCCC" => "CD")
    roman_numeral = replace(roman_numeral, "DD" => "M")

    length_difference = length(original_numeral) - length(roman_numeral)
    return length_difference
end

characters_saved = 0
lines = readlines(joinpath(@__DIR__, "0089_roman.txt"))
for line in lines
    global characters_saved += reduce_to_minimal_form(line)
end
println("Total characters saved: $characters_saved")