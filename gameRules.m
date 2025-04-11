function gameRules()
    % Blackjack Game - Rules
    % Note: The rules text has been updated to reflect the game's unique "Seasons" twist and jackpot feature.
    % The rules text is generated with assistance from ChatGPT.
    
        fprintf("\n====== Casino Blackjack Game Rules ======\n");
        fprintf("\nObjective:\n");
        fprintf("The goal is to have a hand value closer to 21 than the dealer without exceeding 21.\n");
        fprintf("However, the game features a unique 'Seasons' twist that changes gameplay each round!\n\n");
        
        fprintf("Card Values:\n");
        fprintf("- Number Cards (2-10): Face value.\n");
        fprintf("- Face Cards (J, Q, K): 10 points each.\n");
        fprintf("- Ace (A): Normally 1 or 11 (whichever benefits you most), but this changes in Winter.\n\n");
        
        fprintf("Seasons and Their Effects:\n");
        fprintf("1. Autumn: Jackpot bets are halved (e.g., a $10 jackpot bet becomes $5).\n");
        fprintf("2. Spring: Normal gameplay (no special effects).\n");
        fprintf("3. Summer: The dealer must hit on 18 or less, instead of the standard 17.\n");
        fprintf("4. Winter: Aces are worth 12 points instead of 1 or 11.\n");
        fprintf("   - Be cautious, as this can quickly lead to busting if not managed carefully!\n\n");
        
        fprintf("Jackpot Feature:\n");
        fprintf("- You can place a jackpot bet (optional, up to your remaining balance minus your regular bet).\n");
        fprintf("- If you’re dealt two cards of the same rank (e.g., two 7s or two Kings) at the start of a round, you win the jackpot!\n");
        fprintf("- The jackpot accumulates with each jackpot bet and resets to $0 after a win.\n");
        fprintf("- In Autumn, your jackpot bet is halved before adding to the jackpot.\n\n");
        
        fprintf("How to Play:\n");
        fprintf("1. Each player and the dealer are dealt two cards.\n");
        fprintf("2. The dealer shows one card, while the other remains hidden.\n");
        fprintf("3. You can:\n");
        fprintf("   - Hit (draw a card) by typing 'h' or 'hit'\n");
        fprintf("   - Stand (keep your current hand) by typing 's' or 'stand'\n");
        fprintf("   - Note: There’s no double down or split in this version, but you can bet on the jackpot for extra excitement!\n\n");
        
        fprintf("4. The dealer plays according to the season’s rules (see above).\n");
        fprintf("5. If your hand exceeds 21, you bust and lose your bet and jackpot bet (if any).\n");
        fprintf("6. Blackjack (21 with your first two cards) is an instant win unless the dealer also has Blackjack (resulting in a push/tie).\n\n");
        
        fprintf("Payouts:\n");
        fprintf("- Win: 1:1 (Bet $100 → Win $100)\n");
        fprintf("- Blackjack: 3:2 (Bet $100 → Win $150)\n");
        fprintf("- Tie (Push): You keep your regular bet, but lose your jackpot bet (if any).\n");
        fprintf("- Jackpot Win: You receive the full jackpot amount, which resets to $0.\n\n");
    
        fprintf("Press Enter to return to the start game.\n");
        pause;
    end
