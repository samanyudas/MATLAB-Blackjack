%% dealInitialCardsDriver
function dealInitialCardsDriver()
% Function acting as a test driver for the dealInitialCards() function
% Checks by getting initial cards for user and dealer and ensuring they have the cards and removes the played cards from the deck

    deck = createDeck(); % Initalizing Deck
    deck = shuffleDeck(deck); % Initalizing Shuffled Deck
    [userHand, dealerHand, newDeck] = dealInitialCards(deck); % Running dealInitialCards function

    disp("Test 1: User")
    assert(length(userHand) == 2, "❌ User should have 2 cards"); % User can only have 2 initial cards
    disp("✅ Test 1 Passed");

    disp("Test 2: Dealer")
    assert(length(dealerHand) == 2, "❌ Dealer should have 2 cards"); % Dealer can only have 2 initial cards
    disp("✅ Test 2 Passed")

    disp("Test 3: Deck")
    assert(length(newDeck) == 48, "❌ Deck should have 48 cards left"); % Deck can only have 48 cards after initial cards are dealt with
    disp("✅ Test 3 Passed");
end

% dealInitialCardsDriver()