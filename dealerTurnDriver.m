%% dealerTurnDriver
function dealerTurnDriver()
    % Function acting as a test driver for the dealerTurn() function
    % Checking if dealer hits and stands appropriately as per soft 17
            
    % Test 1: Hand < 17 -> Hit
    disp("Test 1: Hand < 17 -> Hit")
    deck = createDeck(); % Initalizing Deck
    hand = [deck(1), deck(2)];
    [hand, deck] = dealerTurn(hand, deck);
    handValue = calculateHandValue(hand);  % Calculate hand value
    assert(handValue >= 17, "❌ Test 1 Failed as Dealer did not hit")  % Check if dealer's hand value is less than or equal to 17
    disp("✅ Test 1 Passed");
        
    % Test 2: Hand = 17 -> Stand
    disp("Test 2: Hand = 17 -> Stand")
    deck = createDeck(); % Initalizing Deck
    hand = [deck(6), deck(10)];
    [hand, temp] = dealerTurn(hand,deck);
    handValue = calculateHandValue(hand);  % Calculate hand value
    assert(handValue == 17,"❌ Test 2 Failed as Dealer did not stand")
    disp("✅ Test 2 Passed");

    % Test 3: Hand > 17 -> Stand
    disp("Test 3: Hand > 17 -> Stand")
    deck = createDeck(); % Initalizing Deck
    [hand, temp] = dealerTurn(hand,deck);
    hand = [deck(11), deck(10)];
    handValue = calculateHandValue(hand);  % Calculate hand value
    assert(handValue >= 17,"❌ Test 3 Failed as Dealer did not stand")
    disp("✅ Test 3 Passed");
end

%dealerTurnDriver()