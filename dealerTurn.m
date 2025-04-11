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
