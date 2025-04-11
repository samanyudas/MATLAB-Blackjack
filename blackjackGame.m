%% BlackJack Game (Main Game File and not Main Menu File)
function blackjackGame()
% Function is the core of the blackjack game which implements and binds all of the code in the folder together.

    while true % Outer 'while loop' to re-run game as per exit request option chosen by user to replay the game
        % Initializing user balance, deck of cards and balance history
        while true
            userBalance = input("Enter User Balance: ",'s'); % Getting the balance input as string
            if ~isempty(userBalance) && ~any(isletter(userBalance)) && ~any(isspace(userBalance)) && all(isstrprop(userBalance, 'digit')) % Checking if the input given is valid or not
                userBalance = str2double(userBalance); % Converting the balance from string data type to numeric data type
                if ~(userBalance == 0) % 0 not accepted as a valid userBalance
                    break;
                else
                    fprintf("Invalid input! Only numbers greater than 0 can be accepted for Balance. \n")
                end
            else
                fprintf("Invalid input! Only positive numbers can be accepted for Balance. \n");
            end
        end
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
    
        % Graph displaying the user's balance over time
        userBalanceGraph(balanceHistory);

        % Asking user to play again but this isn't applicable, if the user has already selected the option to 'exit' while in-game during betting.
        if ~isnan(bet)
            while true
                playAgain = lower(input('Do you want to play again? (yes/no): ', 's')); % Asking  user to play again or not
                if strcmp(playAgain, 'yes') || strcmp(playAgain, 'no')
                    break;
                else
                    fprintf("Invalid input! Please enter 'yes' or 'no'. \n");
                end
            end
        else
            break;
        end


        if strcmp(playAgain, 'no')
            fprintf("\nGame Over!");
            fprintf("\nThank you for visiting Casino Blackjack. Goodbye! \n");
            break; % Exit the  outer 'while loop' to not re-run game as due to the 'no' exit request option chosen by user.
        end
    end
end