%% reShuffleCardsDriver
function reShuffleCardsDriver()
% Function acting as a test driver for the reShuffleCards() function
% Checking if cards are reshuffled or not

    deck = createDeck(); % Initalize Deck
    deck = shuffleDeck(deck); % Initalize Shuffled Deck
    originalDeck = deck; % Copying deck to orginalDeck for future comparisons

    % 1. Full Deck (No reshuffling)
    disp("Test 1: Full Deck")
    deck = reShuffleCards(deck);
    assert(isequal(deck, originalDeck), "❌ Test 1 Failed as Deck was reshuffled.");
    disp("✅ Test 1 Passed");

    % 2. Deck with 4 Cards and Less (Yes Reshuffling)
    disp("Test 2: Deck with 4 Cards and Less")
    deck = deck(1:3); % Reduce deck size
    deck = reShuffleCards(deck);
    assert(length(deck) > 3, "❌ Test 2 Failed as Deck was not reshuffled.");
    disp("✅ Test 2 Passed");

    % 3. Empty Deck (Yes Reshuffling)
    disp("Test 3: Empty Deck")
    deck = []; % Empty deck
    deck = reShuffleCards(deck);
    assert(length(deck) > 3, "❌ Test 3 Failed as Deck was not reshuffled.");
    disp("✅ Test 3 Passed");

    % 4. Edge Case - Exactly 4 Cards (No Reshuffling)
    disp("Test 4: Only 4 Cards in Deck")
    deck = originalDeck(1:4); % Keeping 4 cards in deck
    originalDeck = deck;
    deck = reShuffleCards(deck);
    assert(isequal(deck, originalDeck), "❌ Test 4 Failed as Deck was reshuffled.");
    disp("✅ Test 4 Passed");
end

% reShuffleCardsDriver()