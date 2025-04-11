%% reShuffleCards 
function deck = reShuffleCards(deck)
% Making sure that the deck has atleast 4 cards to continue, else deck 
% gets reshuffled

    if length(deck) < 4 % Minimum 4 cards required to proceed
        fprintf('Not enough cards left in the deck. Shuffling again...\n');
        deck = createDeck(); % Creating new deck, else only 4 cards would be shuffled
        deck = shuffleDeck(deck); % Shuffling cards
    end

end