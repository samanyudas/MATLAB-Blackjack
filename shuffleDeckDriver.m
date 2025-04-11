%% shuffleDeckDriver
function shuffleDeckDriver()
% Function acting as a test driver for the shuffleDeck() function
% Checking if card deck is shuffled or not

    deck = createDeck(); % Initalize Deck
    shuffledDeck = shuffleDeck(deck); %  Initalize Shuffled Deck
    
    assert(~isequal(deck, shuffledDeck), "❌ Test Failed as Deck was not reshuffled.");
    disp("✅ Test Passed")
end

% shuffleDeckDriver()