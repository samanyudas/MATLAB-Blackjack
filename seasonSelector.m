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