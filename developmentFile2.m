% Changes Made from developmentFile1:
% - Improved upon the first version by refining core functions (createDeck(), shuffleDeck(), etc.).
% - Introduced Fisher-Yates shuffle algorithm for better randomization in shuffleDeck().
% - Enhanced userBet() to allow 'exit' option and better input validation.
% - Added reShuffleCards() to ensure sufficient cards in the deck.
% - Implemented calculateHandValue() to handle Aces (1 or 11) and dealerTurn() with rules to hit on 16 or less.
% - Expanded determineWinner() and updateBalance() for accurate win/loss conditions and payouts (1:1 for wins, 3:2 for Blackjack).
% - Main game loop now includes user and dealer turns, with checks for busts and pushes.
% - No seasons or jackpots yet, but added structure for future enhancements.

function deck = createDeck() 
    ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'};
    suits = {'Hearts', 'Diamonds', 'Clubs', 'Spades'};
    values = [2,3,4,5,6,7,8,9,10,10,10,10,11];
    
    deck = struct('Rank', {}, 'Suit', {}, 'Value', {});
    i = 1;
    for suit = 1:length(suits)
        for rank = 1:length(ranks)
            deck(i).Rank = ranks{rank};
            deck(i).Suit = suits{suit};
            deck(i).Value = values(rank);
            i = i + 1;
        end
    end
end
function deck = shuffleDeck(deck)
    % Fisher-Yates Shuffle Algorithm <Random, Switch, Decrement>
    for i = length(deck):-1:2 
        j = randi(i);  
        deck([i, j]) = deck([j, i]);   
    end
end
function [bet] = userBet(userBalance)
        while true
            bet = lower(input("Enter amount to bet or 'exit' to exit game: ",'s')); 
            
            if bet == "exit" 
                bet = NaN; 
                break    
            end
    
            bet = str2double(bet); 
    
            if ~isnan(bet) && bet > 0 && bet <= userBalance
                break 
            else
                fprintf("Invalid amount! Enter a number between 1 and %0.0f \n",userBalance)
            end
        end
    end
function deck = reShuffleCards(deck)
    if length(deck) < 4
        fprintf('Not enough cards left in the deck. Shuffling again...\n');
        deck = shuffleDeck(createDeck());
    end
    
end
function [userHand, dealerHand, deck] = dealInitialCards(deck)
    deck = reShuffleCards(deck);
    dealerHand = [deck(1),deck(4)];
    userHand = [deck(2),deck(3)];
    deck(1:4) = [];
end
function handValue = calculateHandValue(hand)    
    handValue = sum([hand.Value]); 
    numAce = sum(strcmp({hand.Rank}, 'A'));
    while handValue > 21 && numAce > 0
        handValue = handValue - 10; 
        numAce = numAce - 1;
    end
end
function [userHand, deck] = userTurn(userHand, deck)
    while true
        deck = reShuffleCards(deck);
        fprintf('Your hand: ');
        for i = 1:length(userHand)
            fprintf('%s of %s, ', userHand(i).Rank, userHand(i).Suit);
        end
        fprintf('Total: %d\n', calculateHandValue(userHand));

        action = lower(input("Do you want to hit (h) or stand (s)? ", 's'));
        switch action
            case {'s', 'stand'}
                break;
            case {'h', 'hit'}
                if length(deck) >= 1
                    userHand(end+1) = deck(1);
                    deck(1) = []; 
                    if calculateHandValue(userHand) > 21
                        fprintf("You went bust!\n"); 
                        break;
                    end 
                else
                    fprintf("Not enough cards to draw!\n");
                    break;
                end
            otherwise
                fprintf("Invalid choice! Enter 'h' for hit or 's' for stand.\n");
        end
    end
end
function [dealerHand, deck] = dealerTurn(dealerHand, deck)
    deck = reShuffleCards(deck);
    fprintf("Dealer's turn: \n");
    while calculateHandValue(dealerHand) < 17
        dealerHand(end+1) = deck(1);
        deck(1) = []; 
    end
    fprintf("Dealer's full hand: ");
    for i = 1:length(dealerHand)
        fprintf('%s of %s, ', dealerHand(i).Rank, dealerHand(i).Suit); 
    end
    fprintf('Total: %d\n', calculateHandValue(dealerHand));
end
function winner = determineWinner(userHand, dealerHand)

    userScore = calculateHandValue(userHand);
    dealerScore = calculateHandValue(dealerHand);
    if userScore > 21
        winner = 'dealer';
    elseif dealerScore > 21 || userScore > dealerScore
        winner = 'user'; 
    elseif dealerScore > userScore
        winner = 'dealer'; 
    else
        winner = 'push'; 
    end
end
function newBalance = updateBalance(balance, bet, winner, bjHandCheck)
    if winner == "user"
        if bjHandCheck
            winnings = bet * 1.5; 
            balance = balance + winnings;  
            fprintf("Blackjack! You win $%0.0f (1.5x your bet)! New balance: $%0.0f\n", winnings, balance);
        else
            balance = balance + bet;
            fprintf("You win! New balance: $%0.0f\n", balance);
        end
    elseif winner == "dealer"
        balance = balance - bet; 
        fprintf("You lose! New balance: $%0.0f\n", balance);
    else
        fprintf("Push! Balance remains: $%0.0f\n", balance); 
    end
    newBalance = balance;
end

%% BlackJack Game (Main File)
function blackjackGame()
    % Initializing user balance & deck of cards
    userBalance = str2double(input("Enter User Balance: ","s"));
    deck = createDeck();
    disp('Shufffling and dealing cards for the first time...');
    deck = shuffleDeck(deck);  % Shufffling cards for 1st time (initial shuffle)
    
    while userBalance > 0
        % 1. Displaying balance and getting bet
        fprintf('Your current balance: $%0.0f\n', userBalance);
        bet = userBet(userBalance);
        if isnan(bet)
            fprintf("Thanks for playing! You leave with $%0.0f\n",userBalance)
            break
        end
        
        % 2. Dealing Cards (shuffling the deck is managed by function, dealInitialCards)
        [userHand, dealerHand, deck] = dealInitialCards(deck);
        
        % 3. Player's intial hand and dealer's first card and user's turn
        fprintf('\nYour initial cards: %s of %s, %s of %s\n', userHand(1).Rank, userHand(1).Suit, userHand(2).Rank, userHand(2).Suit);
        fprintf('Dealer cards: %s of %s\n', dealerHand(1).Rank, dealerHand(1).Suit);        
        
        % 4. Allowing the user to play, provided they don't have an initial blackjack
        bjHandCheck = length(userHand) == 2 && calculateHandValue(userHand) == 21;
        if bjHandCheck
            fprintf('User has Blackjack! No need to hit or stand.\n');
        else
            % Hit and Stand option is offered to user only when he/she
            % don't have a initial blackjack
            [userHand, deck] = userTurn(userHand, deck);
        end
        
        % 5. Checking is user went bust
        if calculateHandValue(userHand) > 21
            fprintf('You went bust with a total of %d.\n', calculateHandValue(userHand));
            userBalance = updateBalance(userBalance, bet, 'dealer',false);
            continue;
        end

        % 6. Dealer's turn to play, provided the user didn't bust
        [dealerHand, deck] = dealerTurn(dealerHand, deck);

        % 7. Determining the winner and updating the balance
        winner = determineWinner(userHand, dealerHand);
        userBalance = updateBalance(userBalance, bet, winner, bjHandCheck);
    end
    
    % Game over message
    disp("Game Over!")
end

blackjackGame()

%{
function gameRules()
% Blackjack Game - Rules
% Note: The rules of game have been generated by ChatGPT but has been coded by myself

    fprintf("\n====== Blackjack Game Rules ======\n");
    fprintf("\n Objective:\n");
    fprintf("The goal is to have a hand value closer to 21 than the dealer without exceeding 21.\n\n");
    
    fprintf("Card Values:\n");
    fprintf("- Number Cards (2-10): Face value.\n");
    fprintf("- Face Cards (J, Q, K): 10 points each.\n");
    fprintf("- Ace (A): Can be 1 or 11, whichever benefits you most.\n\n");
    
    fprintf("How to Play:\n");
    fprintf("1. Each player and the dealer are dealt two cards.\n");
    fprintf("2. Dealer shows one card, while the other remains hidden.\n");
    fprintf("3. Player can:\n");
    fprintf("   - Hit (draw a card)\n");
    fprintf("   - Stand (keep current hand)\n");
    fprintf("   - Double Down (double bet, take one extra card, then stand)\n");
    fprintf("   - Split (if two same cards, play as separate hands)\n\n");
    
    fprintf("4. Dealer must hit on 16 or less, and stand on 17 or more.\n");
    fprintf("5. If a hand exceeds 21, that player loses (bust).\n");
    fprintf("6. Blackjack (21 with first two cards) is an instant win unless dealer also has Blackjack (push/tie).\n\n");
    
    fprintf("Payouts:\n");
    fprintf("- Win: 1:1 (Bet $100 → Win $100)\n");
    fprintf("- Blackjack: 3:2 (Bet $100 → Win $150)\n");
    fprintf("- Tie (Push): No money won or lost\n\n");

    fprintf("Press Enter to start game.\n");
    pause;
end
%}
%{
clc; % Clear command window
clear; % Clear workspace variables

% Prompting user to enter their name and validating the input
while true
    name = input("Please enter your name: ",'s'); % Getting the name input as string
    if ~isempty(name) && all(isletter(name)) && ~any(isspace(name)) % Checking if the input given is valid or not
        break; % Exiting loop, if valid name entered
    else
        fprintf("Invalid input! Name must contain only alphabets and no spaces.: \n");
    end
end

% Displaying welcome messages
fprintf("\nHello %s, \n",name);
fprintf("Welcome to Casino Blackjack. \n");
fprintf("Your initial cash is $1000. Good luck! \n \n")

% Displaying main menu and prompt user for selection of options
while true
    fprintf("1. View Game Rules\n");
    fprintf("2. Play Blackjack\n");
    fprintf("3. Exit\n");
    num = input("Enter your choice (1-3): ","s"); % Getting the user input as string
    num = str2double(num); % Converting input to numerical value
    if ~isnan(num) && (num == 1 || num == 2 || num == 3) % Validating the input
        break; % Exiting loop if input is valid
    else
        fprintf("Invalid Input Entered! Enter Proper Input! \n");
    end
end

% Processing the user's choice
if num == 1
    gameRules(); % Calling the function "gameRules()" to display game rules
    blackjackGame(); % Starting blackjack game
elseif num == 2
    blackjackGame(); % Starting blackjack game
elseif num == 3
    fprintf("\nThank you for visiting Casino Blackjack. Goodbye!\n"); % Exit message
end
%}