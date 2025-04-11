%% calculateHandValue
function handValue = calculateHandValue(hand, season)
% Function calculates the total value of hand and counts the number of aces
% and returns appropriately the proper value of hand after accounting for
% "Ace handling (10 or 1)"

    handValue = sum([hand.Value]); % Calculates total hand value (by extacting Value field from all elements in hand structure and then adding all the values)
    numAce = sum(strcmp({hand.Rank}, 'A')); % Counting number of aces in hand (by comparing cards)
    
    if strcmp(season, 'Winter')  % If Season is Winter by comparing 'season string' and 'winter'
        handValue = handValue + numAce;  % Aces = 12 (Ace Handling Overriden)
    end
    
    % Convert ace from 11 to 1 if total hand values over 21 and Season is not Winter
    while handValue > 21 && numAce > 0 && ~strcmp(season, 'Winter')
        handValue = handValue - 10; 
        numAce = numAce - 1;
    end
end
