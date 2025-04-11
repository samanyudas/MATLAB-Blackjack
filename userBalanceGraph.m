%% userBalanceGraph
function userBalanceGraph(balanceHistory)
% Function used to graph displaying the user's balance over time

    figure;
    plot(balanceHistory, '-o', 'LineWidth', 2); % Drawing Line of balanceHistory with each point is circled and connected with a solid line with a width size of 2
    xlabel('Round'); % X-axis label
    ylabel('Balance ($)'); % Y-axis label
    title('Progression of Balance of User'); % Title Label
    grid on; % Graph will have grid functionality
end