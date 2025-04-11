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