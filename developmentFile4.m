% Changes Made from developmentFile4:
% - Further refined the third version with additional testing and driver functions for each major function (e.g., createDeckDriver(), shuffleDeckDriver(), etc.).
% - Improved error handling and input validation, especially in userBet() and initial balance input.
% - Ensured all functions use Fisher-Yates shuffle for consistency and added assert statements in drivers for thorough testing.
% - Simplified some logic in calculateHandValue() and dealerTurn() while maintaining seasonal effects.
% - Removed redundant code and comments from previous versions, focusing on clarity and efficiency.
% - Maintained the jackpot and seasonal features, with enhanced visualization through userBalanceGraph().
% - Added documentation for each function’s purpose and behavior, ensuring modularity and readability.
% - This version represents the final, tested, and optimized state of the Blackjack game, with all extensions (seasons, jackpots, visualization) fully integrated.


%% seasonSelector
function [season, effect] = seasonSelector()
% Functions chooses the season and effect randomly using Fisher-Yates Shuffle algorithm and returns it to the function
% NOTE: This BlackJack has a twist, which is "Seasons", there are four seasons and each season brings its own twists in this BlackJack Game.
    seasons = {'Autumn', 'Spring', 'Summer', 'Winter'};
    effects = {'Halves Jackpot Bets', 'Normal', 'Dealer hits on 18', 'Aces worth 12'};

    % Fisher-Yates Shuffle Algorithm <Random, Switch, Decrement>
    for i = length(seasons):-1:2 % Iterate from last till first
        j = randi(i);  % Pick a random index from 1 to i
        seasons([i, j]) = seasons([j, i]);   % Swap seasons(i) with seasons(j) for shuffling
        effects([i, j]) = effects([j, i]);   % Swap effects(i) with effects(j) for shuffling   
    end

    season = seasons{1};  % Picking the shuffled season
    effect = effects{1};  % Picking the shuffled effect
end
%% seasonSelectorDriver
function seasonSelectorDriver()
% Function acting as a test driver for the createDeck() function
% Checking if season and effect are randomly selected or not

    [season1, effect1] = seasonSelector();
    [season2, effect2] = seasonSelector();
    assert(~strcmp(season1, season2) && ~strcmp(effect1, effect2), "❌ Test Failed as season and effect are the same");
    disp("✅ Test passed sucessfully")

end

%seasonSelectorDriver()

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

%% shuffleDeck
function deck = shuffleDeck(deck)
% Function uses Fisher-Yates Shuffle algorithm to randomly give the order of cards in a deck. 

    % Fisher-Yates Shuffle Algorithm <Random, Switch, Decrement>
    for i = length(deck):-1:2 % Iterate from last card till second card
        j = randi(i);  % Pick a random index from 1 to i
        deck([i, j]) = deck([j, i]);   % Swap deck(i) with deck(j) for shuffling
    end
end

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

%% userBet
function [bet, jackpotBet] = userBet(userBalance, jackpot)
% Function make ensures user's bets are numeric and between 0 and 
% userBalance and provides exit option

    while true
        bet = lower(input("Enter amount to bet or 'exit' to exit game: ",'s')); % input bet amount as string
        
        if bet == "exit" % bet option to exit 
            bet = NaN; % bet is NaN as user quits the game
            jackpotBet = 0; 
            break      % break exists here to get rid of the loop <it would not be there, but char's other than numeric convert to NaN>
        end

        bet = str2double(bet); % convert bet to numeric

        % validating bet is as per the parameters (Not NaN, Greater than 0, and, less than Balance of user)
        if ~isnan(bet) && bet > 0 && bet <= userBalance
            while true
                jackpotBet = input(sprintf('Enter bet amount for jackpot ($%0.0f) (0 to skip): ', jackpot), 's');
                jackpotBet = str2double(jackpotBet); % converting string to numeric format
                if ~isnan(jackpotBet) && jackpotBet >= 0 && jackpotBet <= (userBalance - bet)
                    break;
                else
                    fprintf("Invalid jackpot bet! Enter 0 or a number up to %0.0f\n", userBalance - bet);
                end
            end
            break % exit loop, if bet between 0 and userBalance
        else
            jackpotBet = 0;
            % user has inputed characters outside the given range or invalid characters and asking for input again
            fprintf("Invalid amount! Enter a number between 1 and %0.0f \n",userBalance)
        end
    end
end
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

%% dealInitialCards
function [userHand, dealerHand, deck] = dealInitialCards(deck)
% Function gets initial card for first hand play for dealer and user and 
% removes the played cards from the deck

    % Checking if the deck has enough cards
    deck = reShuffleCards(deck);

    dealerHand = [deck(1),deck(4)];  % First and fourth card to dealer
    userHand = [deck(2),deck(3)];  % Second and third card to user
    deck(1:4) = [];      % Removing cards dealt with already
end

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
%% calculateHandValue
function handValue = calculateHandValue(hand, season)
% Function calculates the total value of hand and counts the number of aces
% and returns appropriately the proper value of hand after accounting for
% "Ace handling (10 or 1)"

    handValue = sum([hand.Value]); % Calculates total hand value (by extacting Value field from all elements in hand structure and then adding all the values)
    numAce = sum(strcmp({hand.Rank}, 'A')); % Counting number of aces in hand (by comparing cards)
    
    if strcmp(season, 'Winter')  % If Season is Winter by comparing 'season string' and 'winter'
        handValue = handValue + numAce;  % Aces = 12 (Ace Handling Overriden)
    end
    
    % Convert ace from 11 to 1 if total hand values over 21 and Season is not Winter
    while handValue > 21 && numAce > 0 && ~strcmp(season, 'Winter')
        handValue = handValue - 10; 
        numAce = numAce - 1;
    end
end

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
%% userTurn
function [userHand, deck] = userTurn(userHand, deck, season)
% Function manages the user's turn in Blackjack, by allowing to hit or
% stand

    while true
        % Checking if the deck has enough cards
        deck = reShuffleCards(deck);
        
        % Displaying user's current hand
        fprintf('Your hand: ');
        for i = 1:length(userHand)
            fprintf('%s of %s, ', userHand(i).Rank, userHand(i).Suit);
        end
        fprintf('Total: %d\n', calculateHandValue(userHand, season));

        % Asking user action to hit or stand
        action = input("Do you want to hit (h) or stand (s)? ", 's');
        switch lower(action)
            case {'s', 'stand'} % Checking for 's' or 'stand'
                break; % User stands
            case {'h', 'hit'} % Checking for 'h' or 'hit'
                % Making sure that there is a card to draw
                if length(deck) >= 1
                    % Taking a card from deck
                    userHand(end+1) = deck(1);
                    deck(1) = []; % Removing card used from deck
                    if calculateHandValue(userHand, season) > 21 % User bust as card value above 21
                        fprintf("You went bust!\n"); 
                        break; % Exiting loop if bust
                    end % User hits
                else
                    fprintf("Not enough cards to draw!\n");
                    break; % Exiting loop if deck empty
                end
            otherwise
                fprintf("Invalid choice! Enter 'h' for hit or 's' for stand.\n");
        end
    end
end

%% dealerTurn
function [dealerHand, deck] = dealerTurn(dealerHand, deck, season)
% Function manages the dealer's turn in Blackjack, by hiting cards until
% hand value is 17 or greater

    % Checking if the deck has enough cards
    deck = reShuffleCards(deck);

    fprintf("Dealer's turn: (Season: %s) \n", season);

    if strcmp(season,"Summer") % Comparing 'season string' with 'summer string'
        hitVariable = 18; % 18 if summer
    else
        hitVariable = 17; % 17 if not summer 
    end

    % Dealer hiting until value is 17+ unless season is Summer
    while calculateHandValue(dealerHand, season) < hitVariable
        dealerHand(end+1) = deck(1); % Adding card to dealer's hand
        deck(1) = []; % Removing card played
    end

    % Displaying dealer's final hand
    fprintf("Dealer's full hand: ");
    for i = 1:length(dealerHand) % Iterating through all cards in dealer's hand
        fprintf('%s of %s, ', dealerHand(i).Rank, dealerHand(i).Suit); % Printing each cards in dealer's hand
    end
    fprintf('Total: %d\n', calculateHandValue(dealerHand, season)); % Counting the value of cards in dealer's hand
end

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
%% determineWinner
function winner = determineWinner(userHand, dealerHand, season)
% Function tells who the winner between dealer and user

    % Calculating the hand value of user and dealer
    userScore = calculateHandValue(userHand, season);
    dealerScore = calculateHandValue(dealerHand, season);

    % Winner is being determined based on hand value
    if userScore > 21
        winner = 'dealer'; % User goes bust
    elseif dealerScore > 21 || userScore > dealerScore
        winner = 'user'; % User wins as userScore is more than dealerScore or user has a blackjack (21 hand value)
    elseif dealerScore > userScore
        winner = 'dealer'; % Dealer wins as dealerScore is more than userScore
    else
        winner = 'push'; % Tie game between dealer and user
    end
end

%% updateBalance
function newBalance = updateBalance(balance, bet, jackpotBet, winner, bjHandCheck, jackpot)
% Function updates balance of user by the outcomes of the game played

    if winner == "user"
        if bjHandCheck
            winnings = bet * 1.5; % Blackjack payout is 1.5x the bet
            balance = balance + winnings;  
            fprintf("Blackjack! You win $%0.0f (1.5x your bet)! New balance: $%0.0f\n", winnings, balance);
        else
            balance = balance + bet; % Standard win is 1x the bet
            fprintf("You win! New balance: $%0.0f\n", balance);
        end
    elseif winner == "dealer"
        balance = balance - bet - jackpotBet; % User loses both the betsss
        fprintf("You lose! New balance: $%0.0f\n", balance);
    else
        balance = balance - jackpotBet;
        fprintf("Push! Balance remains: $%0.0f (Jackpot Bet Lost!)\n", balance); % Bet Balance Same but Jackpot Bet Lost
    end
    newBalance = balance; % Returning updated balance
end

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
%% userBalanceGraph
function userBalanceGraph(balanceHistory)
% Function used to graph displaying the user's balance over time

    figure;
    plot(balanceHistory, '-o', 'LineWidth', 2); % Drawing Line of balanceHistory with each point is circled and connected with a solid line with a width size of 2
    xlabel('Round'); % X-axis label
    ylabel('Balance ($)'); % Y-axis label
    title('Progression of Balance of User'); % Title Label
    grid on; % Graph will have grid functionality
end
%% BlackJack Game (Main File)
function blackjackGame()
    % Initializing user balance, deck of cards and balance history
    while true
        userBalance = input("Enter User Balance: ",'s'); % Getting the balance input as string
        if ~isempty(userBalance) && ~any(isletter(userBalance)) && ~any(isspace(userBalance)) && all(isstrprop(userBalance, 'digit')) % Checking if the input given is valid or not
            userBalance = str2double(userBalance); % Converting the balance from string data type to numeric data type
            break;
        else
            fprintf("Invalid input! Only positive numbers can be accepted for Balance. \n");
        end
    end
    userBalance = str2double(userBalance); % Converting the balance from string data type to numeric data type
    balanceHistory = [userBalance];
    jackpot = 0;
    deck = createDeck();
    disp('Shufffling and dealing cards for the first time...');
    deck = shuffleDeck(deck);  % Shufffling cards for 1st time (initial shuffle)
    
    while userBalance > 0
        % 1. Displaying balance & season and getting bets
        [season, effect] = seasonSelector();
        fprintf('Season Now is %s (%s) \n',season,effect);
        fprintf('Your current balance: $%0.0f\n', userBalance);
        [bet, jackpotBet] = userBet(userBalance, jackpot);
        if isnan(bet)
            fprintf("Thanks for playing! You leave with $%0.0f\n",userBalance);
            balanceHistory(end+1) = userBalance;
            break
        end
        
        % Bonus Add: Jackpot Bet - Have 2 of Same Cards and Recieve Jackpot
        if jackpotBet > 0

            if strcmp(season,'Autumn')
                jackpotBet = jackpotBet / 2;
                fprintf('Autumn season halves jackpot bet to $%0.0f\n', jackpotBet);
            end
            jackpot = jackpot + jackpotBet;
            fprintf('Jackpot bet of $%0.0f added. Jackpot now: $%0.0f\n', jackpotBet, jackpot);
        end

        % 2. Dealing Cards (shuffling the deck is managed by function, dealInitialCards)
        [userHand, dealerHand, deck] = dealInitialCards(deck);
        
    % Bonus Add - Checking for Jackpot Win
        if length(userHand) == 2 && strcmp(userHand(1).Rank, userHand(2).Rank)
            fprintf('Jackpot Win! You recieeved %s of %s and %s of %s! Congratulations, You Won %0.0f! \n', userHand(1).Rank, userHand(1).Suit, userHand(2).Rank, userHand(2).Suit,jackpot)
            userBalance = userBalance + jackpot; % User recieves the jackpot money
            jackpot = 0; % Jackpot resets
            balanceHistory(end+1) = userBalance; % Adding jackpot money to plot
        end

        % 3. Player's intial hand and dealer's first card and user's turn
        fprintf('\nYour initial cards: %s of %s, %s of %s\n', userHand(1).Rank, userHand(1).Suit, userHand(2).Rank, userHand(2).Suit);
        fprintf('Dealer cards: %s of %s\n', dealerHand(1).Rank, dealerHand(1).Suit);        
        
        % 4. Allowing the user to play, provided they don't have an initial blackjack
        bjHandCheck = length(userHand) == 2 && calculateHandValue(userHand, season) == 21;
        if bjHandCheck
            fprintf('User has Blackjack! No need to hit or stand.\n');
        else
            % Hit and Stand option is offered to user only when he/she
            % don't have a initial blackjack
            [userHand, deck] = userTurn(userHand, deck, season);
        end
        
        % 5. Checking is user went bust
        if calculateHandValue(userHand, season) > 21
            fprintf('You went bust with a total of %d.\n', calculateHandValue(userHand, season));
            userBalance = updateBalance(userBalance, bet, jackpotBet, 'dealer',false, jackpot);
            balanceHistory(end+1) = userBalance; % To update plot to account for User going bust
            continue;
        end

        % 6. Dealer's turn to play, provided the user didn't bust
        [dealerHand, deck] = dealerTurn(dealerHand, deck, season);

        % 7. Determining the winner, updating the balance and adding userBalance to history for final plotting
        winner = determineWinner(userHand, dealerHand, season);
        userBalance = updateBalance(userBalance, bet, jackpotBet, winner, bjHandCheck, jackpot);
        balanceHistory(end+1) = userBalance;
    end
    
    % Game over message
    disp("Game Over!");

    % Graph displaying the user's balance over time
    userBalanceGraph(balanceHistory);
end


blackjackGame()