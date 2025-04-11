function bjMainMenu()
% Function is the main menu file of the blackjack game

    clc; % Clear command window
    clear; % Clear workspace variables

    % Prompting user to enter their name and validating the input
    while true
        name = input("Please enter your name: ",'s'); % Getting the name input as string
        if ~isempty(name) && all(isletter(name)) && ~any(isspace(name)) % Checking if the input given is valid or not
            break; % Exiting loop, if valid name entered
        else
            fprintf("Invalid input! Name must contain only alphabets and no spaces. \n");
        end
    end

    % Displaying welcome messages
    fprintf("\nHello %s, \n",name);
    fprintf("Welcome to Casino Blackjack. \n");
    fprintf("Your initial cash is $1000. Good luck! \n \n")

    % Displaying main menu and prompt user for selection of options
    while true
        fprintf("1. View Game Rules\n");
        fprintf("2. Play Blackjack\n");
        fprintf("3. Exit\n");
        num = input("Enter your choice (1-3): ","s"); % Getting the user input as string
        num = str2double(num); % Converting input to numerical value
        if ~isnan(num) && (num == 1 || num == 2 || num == 3) % Validating the input
            break; % Exiting loop if input is valid
        else
            fprintf("Invalid Input Entered! Enter Proper Input! \n");
        end
    end

    % Processing the user's choice
    if num == 1
        gameRules(); % Calling the function "gameRules()" to display game rules
        blackjackGame(); % Starting blackjack game
    elseif num == 2
        blackjackGame(); % Starting blackjack game
    elseif num == 3
        fprintf("\nThank you for visiting Casino Blackjack. Goodbye! \n"); % Exit message
    end

end