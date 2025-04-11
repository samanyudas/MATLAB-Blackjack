%% calculateHandValueDriver
function calculateHandValueDriver()
% Function acting as a test driver for the calculateHandValue() function
% Checks Ace Handling

    deck = createDeck(); % Initalizing Deck
    
    % Test 1: No Ace
    disp("Test 1: No Ace")
    hand = [deck(1), deck(2)]; % 2 + 3
    assert(calculateHandValue(hand) == 5, "❌ Test 1 Failed as 2 with 3 is 5"); % Checking Hand Value
    disp("✅ Test 1 Passed");
    

    % Test 2: Ace = 11
    disp("Test 2: Ace = 11")
    hand = [deck(1), deck(13)]; % 2 + Ace
    assert(calculateHandValue(hand) == 13, "❌ Test 2 Failed as 2 with A is 13"); % Checking Hand Value
    disp("✅ Test 2 Passed");

    % Test 3: Ace = 1
    disp("Test 3: Ace = 1")
    hand = [deck(11), deck(12), deck(13)]; % 10 + 10 + Ace
    assert(calculateHandValue(hand) == 21, "❌ Test 3 Failed as 10 and 10 with A is 21"); % Checking Hand Value
    disp("✅ Test 3 Passed");

end

% calculateHandValueDriver()