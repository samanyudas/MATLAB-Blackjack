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