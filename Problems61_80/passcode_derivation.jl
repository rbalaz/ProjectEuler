# Find the shortest possible passcode that satisfies all the order rules

function validate_rules_up_to_index(rules, index, current_combination)
    for i in 1:index
        rule = rules[i]
        first_index = findfirst(==(rule[1]), current_combination)
        second_index = findfirst(==(rule[2]), current_combination)
        if first_index > second_index
            return false
        end
    end
    return true
end

# Count number of unique numbers in the combinations
combinations = read(joinpath(@__DIR__, "0079_keylog.txt"), String)
rows = split(combinations, "\n")
unique_numbers = Set{Int}()
for row in rows
    for number in row
        if !(number in unique_numbers)
            push!(unique_numbers, parse(Int, number))
        end
    end
end
# Evaluate each combination, create order rules
precedence_rules = Set{Tuple{Int, Int}}()
for row in rows
    if row == ""
        continue
    end
    first = parse(Int, row[1])
    second = parse(Int, row[2])
    third = parse(Int, row[3])
    if !((first, second) in precedence_rules)
        push!(precedence_rules, (first, second))
    end
    if !((first, third) in precedence_rules)
        push!(precedence_rules, (first, third))
    end
    if !((second, third) in precedence_rules)
        push!(precedence_rules, (second, third))
    end
end

# Use rules to determine the password
number_of_rules = length(precedence_rules)
rules_collected = collect(precedence_rules)
password = [] 
for i in 1:number_of_rules
    rule = rules_collected[i]
    index_of_first = findfirst(==(rule[1]), password)
    index_of_second = findfirst(==(rule[2]), password)
    if index_of_first === nothing && index_of_second === nothing
        push!(password, rule[1])
        push!(password, rule[2])
    end
    if index_of_first === nothing && index_of_second !== nothing
        insert!(password, index_of_second, rule[1])
    end
    if index_of_first !== nothing && index_of_second === nothing
        insert!(password, index_of_first + 1, rule[2])
    end
    if index_of_first !== nothing && index_of_second !== nothing
        if index_of_first > index_of_second
            password_copy_before_delete = copy(password)
            # Try moving the second
            deleteat!(password_copy_before_delete, index_of_second)
            rules_validated = false
            for j=index_of_first:1:-1
                password_copy = copy(password_copy_before_delete)
                insert!(password_copy, j, rule[2])
                if validate_rules_up_to_index(rules_collected, i, password_copy)
                    global password = password_copy
                    rules_validated = true
                    break
                end
            end
            # If that didn't work, try moving the first
            if !rules_validated
                password_copy_before_delete = copy(password)
                deleteat!(password_copy_before_delete, index_of_first)
                for j=index_of_second:length(password_copy_before_delete):1
                    password_copy = copy(password_copy_before_delete)
                    insert!(password_copy, j, rule[1])
                    if validate_rules_up_to_index(rules_collected, i, password_copy)
                        global password = password_copy
                        rules_validated = true
                        break
                    end
                end
            end

            if !rules_validated
                # Try moving simultaneously both
                password_copy_before_delete = copy(password)
                deleteat!(password_copy_before_delete, index_of_second)
                for j=length(password_copy_before_delete):-1:1
                    password_copy_inner_before_delete = copy(password_copy_before_delete)
                    insert!(password_copy_inner_before_delete, j, rule[2])
                    index_of_first_new = findfirst(==(rule[1]), password_copy_inner_before_delete)
                    deleteat!(password_copy_inner_before_delete, index_of_first_new)
                    for k=1:j
                        password_copy = copy(password_copy_inner_before_delete)
                        insert!(password_copy, k, rule[1])
                        if validate_rules_up_to_index(rules_collected, i, password_copy)
                            global password = password_copy
                            rules_validated = true
                            break
                        end
                    end
                    if rules_validated
                        break
                    end
                end
            end
        end
    end
end
println("Final password: " * join(password, ""))