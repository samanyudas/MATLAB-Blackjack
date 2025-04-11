%% createDeck
function deck = createDeck()
% Function creates a deck of 52 cards with defined Ranks, Suits and Values in
% a standard deck of cards available when  Blackjack

    % Establishing card ranks, suits and values
    ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'};
    suits = {'Hearts', 'Diamonds', 'Clubs', 'Spades'};
    values = [2:10, 10, 10, 10, 11];  % Assume Ace is 11 (Handled in calculateHandValue.m file)
    
    % Creating array of structures to store card deck in structure array "deck"
    deck = struct('Rank', {}, 'Suit', {}, 'Value', {});

    % Intialising the card index
    index = 1;
    % Iterating on suits and ranks to fill the deck
    for suit = 1:length(suits)
        for rank = 1:length(ranks)
            % Adding Values to Ranks, Suits and Values
            deck(index).Rank = ranks{rank};
            deck(index).Suit = suits{suit};
            deck(index).Value = values(rank);
            index = index + 1; % Increment the index to move to the next card
        end
    end
end