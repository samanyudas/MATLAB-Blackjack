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
