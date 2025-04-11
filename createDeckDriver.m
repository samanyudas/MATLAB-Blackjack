%% createDeckDriver
function createDeckDriver()
% Function acting as a test driver for the createDeck() function
% Checking if card deck exists and what are the values of cards

    deck = createDeck(); % Getting deck
    
    % Displaying deck
    fprintf('Card Deck:\n');
    for i = 1:length(deck)
        fprintf('%0.0f. %s of %s (Card Value: %0.0f)\n',i, deck(i).Rank, deck(i).Suit, deck(i).Value);
    end
end

%createDeckDriver()
