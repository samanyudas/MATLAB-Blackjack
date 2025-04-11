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
