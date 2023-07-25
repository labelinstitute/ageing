function [strategyDeviationS,heuristicS,strategySequenceS,myStrategySequenceS,...
    strategyDeviationC1,heuristicC1,strategySequenceC1,myStrategySequenceC1,...
    strategyDeviationC2,heuristicC2,strategySequenceC2,myStrategySequenceC2,...
    strategyDeviationC3,heuristicC3,strategySequenceC3,myStrategySequenceC3] = ...
    strategies(taskS,choiceS,taskC1,choiceC1,taskC2,...
    choiceC2,taskC3,choiceC3)
%% For Treat S
task = taskS;
choice = choiceS;

% strat1: Maximizing Absolutely
[ strategy1, mystrategy1 ] = strategy1Matcher( task, choice );
strat1deviationS = nnz(mystrategy1);

% strat2: Maximizing Item 1 or Equivalently, Minimizing Item 2
[ strategy2, mystrategy2 ] = strategy2Matcher( task, choice);
strat2deviationS = nnz(mystrategy2);

% strat3: Maximizing Item 2 or Equivalently, Minimizing Item 1
[ strategy3, mystrategy3 ] = strategy3Matcher( task, choice );
strat3deviationS = nnz(mystrategy3);

% strat4: Minimizing Absolutely
[ strategy4, mystrategy4 ] = strategy4Matcher( task, choice );
strat4deviationS = nnz(mystrategy4);

% strat5: Equalizing
[ strategy5, mystrategy5 ] = strategy5Matcher( task, choice );
strat5deviationS = nnz(mystrategy5);

%Note: there is no strategy 6, 7, 8, or 9 for Treatment S...skip to 10

% strat10: Max-min
[ strategy10, mystrategy10 ] = strategy10Matcher( task, choice);
strat10deviationS = nnz(mystrategy10);

deviationVector = [strat1deviationS, strat2deviationS, ...
    strat3deviationS, strat4deviationS, strat5deviationS, ...
    100, 100, 100, ...
    100, strat10deviationS];

mindeviationS = min(deviationVector);
heuristicS = find(deviationVector == mindeviationS);

strategyDeviationS = zeros(10,1);
strategyDeviationS = [strat1deviationS,strat2deviationS,strat3deviationS,...
    strat4deviationS,strat5deviationS,0,0,0,0,strat10deviationS];

zerosVector = zeros(35,1);
strategySequenceS = cat(2,strategy1,strategy2,strategy3,strategy4,strategy5,zerosVector,zerosVector,zerosVector,zerosVector,strategy10);
myStrategySequenceS = cat(2,mystrategy1,mystrategy2,mystrategy3,mystrategy4,mystrategy5,zerosVector,zerosVector,zerosVector,zerosVector,mystrategy10);

%% For Treat C3435
task = taskC1;
choice = choiceC1;

% strat1: Maximizing Absolutely
[ strategy1, mystrategy1 ] = strategy1Matcher( task, choice );
strat1deviationC1 = nnz(mystrategy1);

% strat2: Maximizing Item 1 
[ strategy2, mystrategy2 ] = strategy2Matcher( task, choice );
strat2deviationC1 = nnz(mystrategy2);

% strat3: Maximizing Item 2 
[ strategy3, mystrategy3 ] = strategy3Matcher( task, choice );
strat3deviationC1 = nnz(mystrategy3);

% strat4: Minimizing Absolutely
[ strategy4, mystrategy4 ] = strategy4Matcher( task, choice );
strat4deviationC1 = nnz(mystrategy4);

% strat5: Equalizing
[ strategy5, mystrategy5 ] = strategy5Matcher( task, choice );
strat5deviationC1 = nnz(mystrategy5);

% strat6: Maximizing Item 3
[ strategy6, mystrategy6 ] = strategy6Matcher( task, choice );
strat6deviationC1 = nnz(mystrategy6);

% strat7: Maximizing Item 1 + Item 2
[ strategy7, mystrategy7 ] = strategy7Matcher( task, choice );
strat7deviationC1 = nnz(mystrategy7);

% strat8: Maximizing Item 1 + Item 3
[ strategy8, mystrategy8 ] = strategy8Matcher( task, choice );
strat8deviationC1 = nnz(mystrategy8);

% strat9: Maximizing Item 2 + Item 3
[ strategy9, mystrategy9 ] = strategy9Matcher( task, choice );
strat9deviationC1 = nnz(mystrategy9);

% strat10: Max-min
[ strategy10, mystrategy10 ] = strategy10Matcher( task, choice );
strat10deviationC1 = nnz(mystrategy10);

deviationVector = [strat1deviationC1, strat2deviationC1, ...
    strat3deviationC1, strat4deviationC1, strat5deviationC1, ...
    strat6deviationC1, strat7deviationC1, strat8deviationC1, ...
    strat9deviationC1, strat10deviationC1];

mindeviationC1 = min(deviationVector);
heuristicC1 = find(deviationVector == mindeviationC1);

strategyDeviationC1 = zeros(10,1);
strategyDeviationC1 = [strat1deviationC1,strat2deviationC1,strat3deviationC1,...
    strat4deviationC1,strat5deviationC1,strat6deviationC1,strat7deviationC1,...
    strat8deviationC1,strat9deviationC1,strat10deviationC1];

zerosVector = zeros(35,1);
strategySequenceC1 = cat(2,strategy1,strategy2,strategy3,strategy4,strategy5,strategy6,strategy7,strategy8,strategy9,strategy10);
myStrategySequenceC1 = cat(2,mystrategy1,mystrategy2,mystrategy3,mystrategy4,mystrategy5,mystrategy6,mystrategy7,mystrategy8,mystrategy9,mystrategy10);

%% For Treat C3445
task = taskC2;
choice = choiceC2;

% strat1: Maximizing Absolutely
[ strategy1, mystrategy1 ] = strategy1Matcher( task, choice );
strat1deviationC2 = nnz(mystrategy1);

% strat2: Maximizing Item 1 (which is Item 3)
[ strategy2, mystrategy2 ] = strategy2Matcher( task, choice );
strat2deviationC2 = nnz(mystrategy2);

% strat3: Maximizing Item 2 (which is Item 4)
[ strategy3, mystrategy3 ] = strategy3Matcher( task, choice );
strat3deviationC2 = nnz(mystrategy3);

% strat4: Minimizing Absolutely
[ strategy4, mystrategy4 ] = strategy4Matcher( task, choice );
strat4deviationC2 = nnz(mystrategy4);

% strat5: Equalizing
[ strategy5, mystrategy5 ] = strategy5Matcher( task, choice );
strat5deviationC2 = nnz(mystrategy5);

% strat6: Maximizing Item 3 (which is Item 5)
[ strategy6, mystrategy6 ] = strategy6Matcher( task, choice );
strat6deviationC2 = nnz(mystrategy6);

% strat7: Maximizing Item 1 + Item 2
[ strategy7, mystrategy7 ] = strategy7Matcher( task, choice );
strat7deviationC2 = nnz(mystrategy7);

% strat8: Maximizing Item 1 + Item 3
[ strategy8, mystrategy8 ] = strategy8Matcher( task, choice );
strat8deviationC2 = nnz(mystrategy8);

% strat9: Maximizing Item 2 + Item 3
[ strategy9, mystrategy9 ] = strategy9Matcher( task, choice );
strat9deviationC2 = nnz(mystrategy9);

% strat10: Max-min
[ strategy10, mystrategy10 ] = strategy10Matcher( task, choice );
strat10deviationC2 = nnz(mystrategy10);

deviationVector = [strat1deviationC2, strat2deviationC2, ...
    strat3deviationC2, strat4deviationC2, strat5deviationC2, ...
    strat6deviationC2, strat7deviationC2, strat8deviationC2, ...
    strat9deviationC2, strat10deviationC2];

mindeviationC2 = min(deviationVector);
heuristicC2 = find(deviationVector == mindeviationC2);

strategyDeviationC2 = zeros(10,1);
strategyDeviationC2 = [strat1deviationC2,strat2deviationC2,strat3deviationC2,...
    strat4deviationC2,strat5deviationC2,strat6deviationC2,strat7deviationC2,...
    strat8deviationC2,strat9deviationC2,strat10deviationC2];

zerosVector = zeros(35,1);
strategySequenceC2 = cat(2,strategy1,strategy2,strategy3,strategy4,strategy5,strategy6,strategy7,strategy8,strategy9,strategy10);
myStrategySequenceC2 = cat(2,mystrategy1,mystrategy2,mystrategy3,mystrategy4,mystrategy5,mystrategy6,mystrategy7,mystrategy8,mystrategy9,mystrategy10);

%% For Treat 3545
task = taskC3;
choice = choiceC3;

% strat1: Maximizing Absolutely
[ strategy1, mystrategy1 ] = strategy1Matcher( task, choice );
strat1deviationC3 = nnz(mystrategy1);

% strat2: Maximizing Item 1 
[ strategy2, mystrategy2 ] = strategy2Matcher( task, choice );
strat2deviationC3 = nnz(mystrategy2);

% strat3: Maximizing Item 2 
[ strategy3, mystrategy3 ] = strategy3Matcher( task, choice );
strat3deviationC3 = nnz(mystrategy3);

% strat4: Minimizing Absolutely
[ strategy4, mystrategy4 ] = strategy4Matcher( task, choice );
strat4deviationC3 = nnz(mystrategy4);

% strat5: Equalizing
[ strategy5, mystrategy5 ] = strategy5Matcher( task, choice );
strat5deviationC3 = nnz(mystrategy5);

% strat6: Maximizing Item 3
[ strategy6, mystrategy6 ] = strategy6Matcher( task, choice );
strat6deviationC3 = nnz(mystrategy6);

% strat7: Maximizing Item 1 + Item 2
[ strategy7, mystrategy7 ] = strategy7Matcher( task, choice );
strat7deviationC3 = nnz(mystrategy7);

% strat8: Maximizing Item 1 + Item 3
[ strategy8, mystrategy8 ] = strategy8Matcher( task, choice );
strat8deviationC3 = nnz(mystrategy8);

% strat9: Maximizing Item 2 + Item 3
[ strategy9, mystrategy9 ] = strategy9Matcher( task, choice );
strat9deviationC3 = nnz(mystrategy9);

% strat10: Max-min
[ strategy10, mystrategy10 ] = strategy10Matcher( task, choice );
strat10deviationC3 = nnz(mystrategy10);

deviationVector = [strat1deviationC3, strat2deviationC3, ...
    strat3deviationC3, strat4deviationC3, strat5deviationC3, ...
    strat6deviationC3, strat7deviationC3, strat8deviationC3, ...
    strat9deviationC3, strat10deviationC3];

mindeviationC3 = min(deviationVector);
heuristicC3 = find(deviationVector == mindeviationC3);

strategyDeviationC3 = zeros(10,1);
strategyDeviationC3 = [strat1deviationC3,strat2deviationC3,strat3deviationC3,...
    strat4deviationC3,strat5deviationC3,strat6deviationC3,strat7deviationC3,...
    strat8deviationC3,strat9deviationC3,strat10deviationC3];

strategySequenceC3 = cat(2,strategy1,strategy2,strategy3,strategy4,strategy5,strategy6,strategy7,strategy8,strategy9,strategy10);
myStrategySequenceC3 = cat(2,mystrategy1,mystrategy2,mystrategy3,mystrategy4,mystrategy5,mystrategy6,mystrategy7,mystrategy8,mystrategy9,mystrategy10);

end

