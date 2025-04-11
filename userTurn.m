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