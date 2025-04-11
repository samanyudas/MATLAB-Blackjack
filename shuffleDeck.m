%% shuffleDeck
function deck = shuffleDeck(deck)
% Function uses Fisher-Yates Shuffle algorithm to randomly give the order of cards in a deck. 

    % Fisher-Yates Shuffle Algorithm <Random, Switch, Decrement>
    for i = length(deck):-1:2 % Iterate from last card till second card
        j = randi(i);  % Pick a random index from 1 to i
        deck([i, j]) = deck([j, i]);   % Swap deck(i) with deck(j) for shuffling
    end
end
