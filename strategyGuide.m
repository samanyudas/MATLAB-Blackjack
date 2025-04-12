function strategyGuide()
    % Define basic strategy table
    % Rows: Player's hand total (5 to 21)
    % Columns: Dealer's upcard (2-10, 11 for Ace)
    % 0 = Hit, 1 = Stand
    strategyTable = [
      % 2, 3, 4, 5, 6, 7, 8, 9, 10,A
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 5
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 6
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 7
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 8
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 9
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 10
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0; % 11
        0, 0, 1, 1, 1, 0, 0, 0, 0, 0; % 12 (Stand on 4-6, Hit else)
        0, 0, 1, 1, 1, 0, 0, 0, 0, 0; % 13 (Stand on 4-6, Hit else)
        0, 0, 1, 1, 1, 0, 0, 0, 0, 0; % 14 (Stand on 4-6, Hit else)
        0, 0, 1, 1, 1, 0, 0, 0, 0, 0; % 15 (Stand on 4-6, Hit else)
        0, 0, 1, 1, 1, 0, 0, 0, 0, 0; % 16 (Stand on 4-6, Hit else)
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1; % 17 (Stand)
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1; % 18 (Stand)
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1; % 19 (Stand)
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1; % 20 (Stand)
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1; % 21 (Stand)
    ];
    dealerValues = [2:10, 11]; % 11 represents Ace

    % Asking User for input
    userTotal = input('Enter your hand total (5-21): ');
    dealerUpcard = input('Enter dealer''s upcard value (2-10 or 11 for Ace): ');

    % Checking input is valid or not valid
    if isempty(userTotal) || isempty(dealerUpcard) || userTotal < 5 || userTotal > 21
        fprintf('Invalid input! Totals must be 5-21.\n');
        return;
    end
    % Making sure that dealerUpcard is same as dealerValues
    validDealerUpcard = find(dealerValues == dealerUpcard);
    if isempty(validDealerUpcard)
        fprintf('Invalid dealer upcard! Must be 2-10 or 11 (Ace).\n');
        return;
    end
    col = validDealerUpcard(1); % Using the first match

    % Mapping inputs to strategy table
    row = min(max(1, userTotal - 4), size(strategyTable, 1)); % Maps 5 to 1, 21 to 17

    % Strategy (0 = Hit, 1 = Stand)
    action = strategyTable(row, col);
    if action == 0
        fprintf('Recommendation: Hit\n');
    else
        fprintf('Recommendation: Stand\n');
    end
end