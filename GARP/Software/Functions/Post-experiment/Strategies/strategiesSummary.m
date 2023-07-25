function [ strategySummary ] = ...
    strategiesSummary( i,subjID,strategySummary,strategyDeviationS,...
    strategyUMAXdeviationS,strategyDeviationC1,strategyDeviationC2,...
    strategyDeviationC3,strategyUMAXdeviationC)

    strategySummary(i,1) = subjID;
    % Treat S - number of choices consistent with each heuristic
    strategySummary(i,2) = 35 - strategyDeviationS(1);
    strategySummary(i,3) = 35 - strategyDeviationS(2);
    strategySummary(i,4) = 35 - strategyDeviationS(3);
    strategySummary(i,5) = 35 - strategyDeviationS(4);
    strategySummary(i,6) = 35 - strategyDeviationS(5);
    strategySummary(i,7) = 35 - strategyDeviationS(6);
    strategySummary(i,8) = 35 - strategyUMAXdeviationS;
    
    % Treat C - number of choices consistent with each heuristic
    strategySummary(i,9) = 105 - (strategyDeviationC1(1)+...
        strategyDeviationC2(1) + strategyDeviationC3(1));
    strategySummary(i,10) = 105 - (strategyDeviationC1(2)+...
        strategyDeviationC2(2) + strategyDeviationC3(2));
    strategySummary(i,11) = 105 - (strategyDeviationC1(3)+...
        strategyDeviationC2(3) + strategyDeviationC3(3));
    strategySummary(i,12) = 105 - (strategyDeviationC1(4)+...
        strategyDeviationC2(4) + strategyDeviationC3(4));
    strategySummary(i,13) = 105 - (strategyDeviationC1(5)+...
        strategyDeviationC2(5) + strategyDeviationC3(5));
    strategySummary(i,14) = 105 - (strategyDeviationC1(6)+...
        strategyDeviationC2(6) + strategyDeviationC3(6));
    strategySummary(i,15) = 105 - (strategyDeviationC1(7)+...
        strategyDeviationC2(7) + strategyDeviationC3(7));
    strategySummary(i,16) = 105 - (strategyDeviationC1(8)+...
        strategyDeviationC2(8) + strategyDeviationC3(8));
    strategySummary(i,17) = 105 - (strategyDeviationC1(9)+...
        strategyDeviationC2(9) + strategyDeviationC3(9));
    strategySummary(i,18) = 105 - (strategyDeviationC1(10)+...
        strategyDeviationC2(10) + strategyDeviationC3(10));
    strategySummary(i,19) = 105 - strategyUMAXdeviationC;
    
    % Treat S and Treat C, combined - numbere of choices consistent with
    % heuristics
    strategySummary(i,20) = 140 - (strategyDeviationS(1) + ...     %absolutely maximizing
        strategyDeviationC1(1) + strategyDeviationC2(1) + strategyDeviationC3(1));
    strategySummary(i,21) = 35 - (strategyDeviationS(2));          %maximizing item 1
    strategySummary(i,22) = 35 - (strategyDeviationS(3));          %maximizing item 2
    strategySummary(i,23) = 140 - (strategyDeviationS(4) + ...     %absolutely minimizing
        strategyDeviationC1(4) + strategyDeviationC2(4) + strategyDeviationC3(4));
    strategySummary(i,24) = 140 - (strategyDeviationS(5) + ...     %minimizing difference or equalizing 
        strategyDeviationC1(5) + strategyDeviationC2(5) + strategyDeviationC3(5));
    strategySummary(i,25) = 105 - (strategyDeviationC1(2) + ...    %maximizing item 3
        strategyDeviationC2(2) + strategyDeviationC3(2));
    strategySummary(i,26) = 105 - (strategyDeviationC1(3) + ...    %maximizing item 4
        strategyDeviationC2(3) + strategyDeviationC3(3));
    strategySummary(i,27) = 105 - (strategyDeviationC1(6) + ...    %maximizing item 5
        strategyDeviationC2(6) + strategyDeviationC3(6));
    strategySummary(i,28) = 105 - (strategyDeviationC1(7) + ...    %maximizing item 3 + 4
        strategyDeviationC2(7) + strategyDeviationC3(7));
    strategySummary(i,29) = 105 - (strategyDeviationC1(8) + ...    %maximizing item 3 + 5
        strategyDeviationC2(8) + strategyDeviationC3(8));
    strategySummary(i,30) = 105 - (strategyDeviationC1(9) + ...    %maximizing item 4 + 5
        strategyDeviationC2(9) + strategyDeviationC3(9));
    strategySummary(i,31) = 140 - (strategyDeviationS(10) + ...    %maximizing the minimum
        strategyDeviationC1(10) + strategyDeviationC2(10) + strategyDeviationC3(10));
    strategySummary(i,32) = 140 - (strategyUMAXdeviationS + ...
        strategyUMAXdeviationC);

end

