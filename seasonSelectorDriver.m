%% seasonSelectorDriver
function seasonSelectorDriver()
% Function acting as a test driver for the createDeck() function
% Checking if season and effect are randomly selected or not

    [season1, effect1] = seasonSelector();
    [season2, effect2] = seasonSelector();
    assert(~strcmp(season1, season2) && ~strcmp(effect1, effect2), "❌ Test Failed as season and effect are the same");
    disp("✅ Test passed sucessfully")

end

%seasonSelectorDriver()