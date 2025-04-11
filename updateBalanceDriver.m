%% updateBalanceDriver
function updateBalanceDriver()
    % Function acting as a test driver for the updateBalance() function
    % Checking if balance of user is being updated by the outcomes of the game played or not

    bet = 1000; % initialising bet
    balance = 10000; % initialising starting balance

    % Test 1: User wins without blackjack
    disp("Test 1: User wins without blackjack")
    winner = "user";
    bjHandCheck = false; 
    newBalance = updateBalance(balance, bet, winner, bjHandCheck); % Calling function to run
    afterBetBalance = balance + (bet);
    assert(newBalance == afterBetBalance, "❌ Test 1 Failed: Incorrect balance after User wins without blackjack") % Checking Balance before and after are Same or nOt
    disp("✅ Test 1 Passed");
    
    % Test 2: User wins with blackjack
    disp("Test 2: User wins with blackjack")
    winner = "user";
    bjHandCheck = true; 
    newBalance = updateBalance(balance, bet, winner, bjHandCheck); % Calling function to run
    afterBetBalance = balance + (bet*1.5);
    assert(newBalance == afterBetBalance, "❌ Test 2 Failed: Incorrect balance after User wins with blackjack") % Checking Balance before and after are Same or nOt
    disp("✅ Test 2 Passed");
    
    % Test 3: User loses, Dealer wins
    disp("Test 3: User loses, Dealer wins")
    winner = "dealer";
    bjHandCheck = false; 
    newBalance = updateBalance(balance, bet, winner, bjHandCheck); % Calling function to run
    afterBetBalance = balance - bet;
    assert(newBalance == afterBetBalance, "❌ Test 3 Failed: Incorrect balance after User wins with blackjack") % Checking Balance before and after are Same or nOt
    disp("✅ Test 3 Passed");

    % Test 4: Push between User and Dealer
    disp("Test 4: Push between User and Dealer")
    winner = "push";
    bjHandCheck = false;
    newBalance = updateBalance(balance, bet, winner, bjHandCheck); % Calling function to run
    assert(newBalance == balance, "❌ Test 4 Failed: Incorrect balance after push") % Checking Balance before and after are Same or nOt
    disp("✅ Test 4 Passed");

end

% updateBalanceDriver()