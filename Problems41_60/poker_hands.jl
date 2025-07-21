# Given hands provided in file poker.txt, how many times does player 1 win?

function sort_poker(hand)
    values = [card[1] for card in hand]
    return sort(values, by=x -> findfirst(isequal(x), ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']))
end

function royal_flush(hand)
    return flush(hand) && sort_poker(hand) == ['T', 'J', 'Q', 'K', 'A']
end

function straight_flush(hand)
    return straight(hand) && flush(hand)
end

function straight_flush_rank(hand)
    sorted_cards = sort_poker(hand)
    return sorted_cards[5]
end

function four_of_a_kind(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[1] == sorted_cards[4] || sorted_cards[2] == sorted_cards[5]
end

function four_of_a_kind_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[2]
end

function full_house(hand)
    sorted_cards = sort([card[1] for card in hand])
    return (sorted_cards[1] == sorted_cards[3] && sorted_cards[4] == sorted_cards[5]) ||
           (sorted_cards[1] == sorted_cards[2] && sorted_cards[3] == sorted_cards[5])
end

function full_house_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[3]
end

function flush(hand)
    sorted_cards = sort([card[2] for card in hand])
    return sorted_cards[1] == sorted_cards[5]
end

function flush_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[5]
end

function straight(hand)
    sorted_cards = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
    sorted_hand = sort_poker(hand)
    first_index = findfirst(isequal(sorted_hand[1]), sorted_cards)
    for i in 2:5
        if findfirst(isequal(sorted_hand[i]), sorted_cards) != first_index + (i - 1)
            return false
        end
    end
    return true
end

function straight_rank(hand)
    sorted_hand = sort_poker(hand)
    return sorted_hand[5]
end

function three_of_a_kind(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[1] == sorted_cards[3] || sorted_cards[2] == sorted_cards[4] || sorted_cards[3] == sorted_cards[5]
end

function three_of_a_kind_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[3]
end

function two_pairs(hand)
    sorted_cards = sort([card[1] for card in hand])
    return (sorted_cards[1] == sorted_cards[2] && sorted_cards[3] == sorted_cards[4]) ||
           (sorted_cards[1] == sorted_cards[2] && sorted_cards[4] == sorted_cards[5]) ||
           (sorted_cards[2] == sorted_cards[3] && sorted_cards[4] == sorted_cards[5])
end

function two_pairs_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    return sorted_cards[4]
end

function one_pair(hand)
    sorted_cards = unique(sort([card[1] for card in hand]))
    return length(sorted_cards) == 4
end

function one_pair_rank(hand)
    sorted_cards = sort([card[1] for card in hand])
    if sorted_cards[1] == sorted_cards[2]
        return sorted_cards[1]
    elseif sorted_cards[2] == sorted_cards[3]
        return sorted_cards[2]
    elseif sorted_cards[3] == sorted_cards[4]
        return sorted_cards[3]
    else
        return sorted_cards[4]
    end
end

function high_card(hand, exclusions=[])
    sorted_cards = sort_poker(hand)
    for i = length(sorted_cards):-1:1
        if sorted_cards[i][1] in exclusions
            continue
        end
        return sorted_cards[i][1]
    end
end

function evaluate_hand(hand)
    if royal_flush(hand)
        return 10, 0
    elseif straight_flush(hand)
        return 9, straight_flush_rank(hand)
    elseif four_of_a_kind(hand)
        return 8, four_of_a_kind_rank(hand)
    elseif full_house(hand)
        return 7, full_house_rank(hand)
    elseif flush(hand)
        return 6, flush_rank(hand)
    elseif straight(hand)
        return 5, straight_rank(hand)
    elseif three_of_a_kind(hand)
        return 4, three_of_a_kind_rank(hand)
    elseif two_pairs(hand)
        return 3, two_pairs_rank(hand)
    elseif one_pair(hand)
        return 2, one_pair_rank(hand)
    else
        return 1, high_card(hand)
    end
end

lines = readlines(joinpath(@__DIR__, "0054_poker.txt"))
poker_hands_player1 = []
poker_hands_player2 = []
for line in lines
    cards = split(line, " ")
    hand1 = cards[1:5]
    hand2 = cards[6:10]
    push!(poker_hands_player1, hand1)
    push!(poker_hands_player2, hand2)
end

player1_wins = 0
for i in eachindex(poker_hands_player1)
    hand1 = poker_hands_player1[i]
    hand2 = poker_hands_player2[i]

    score1 = evaluate_hand(hand1)
    score2 = evaluate_hand(hand2)
    if score1[1] > score2[1]
        global player1_wins += 1
    elseif score1[1] == score2[1]
        sorted_cards = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
        score1_rank = findfirst(isequal(score1[2]), sorted_cards)
        score2_rank = findfirst(isequal(score2[2]), sorted_cards)
        if score1_rank > score2_rank
            global player1_wins += 1
        elseif score1_rank == score2_rank
            score1_rank = findfirst(isequal(high_card(hand1, [score1[2]])), sorted_cards)
            score2_rank = findfirst(isequal(high_card(hand2, [score2[2]])), sorted_cards)
            if score1_rank > score2_rank
                global player1_wins += 1
            end
        end
    end
end

println("Player 1 wins: ", player1_wins, " times.")