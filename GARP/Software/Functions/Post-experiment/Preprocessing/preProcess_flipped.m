function [choiceA,rxnA,orderA,choiceS,rxnS,orderS,choiceC1,rxnC1,orderC1,...
        choiceC2,rxnC2,orderC2,choiceC3,rxnC3,orderC3] = ...
        preProcess_flipped(taskA,taskS,taskC1,taskC2,taskC3,choice,trialOrder,...
        orderAold,orderSold,orderC1old,orderC2old,orderC3old,behavioralSecs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Unshuffle the choices, and corresponding response times, and make sure the that they get paired to the right trials
aIndex = 1;
sIndex = 1;
c1Index = 1;
c2Index = 1;
c3Index = 1;
choiceA = zeros(length(taskA),1);
rxnA = zeros(length(taskA),1);
orderA = zeros(length(taskA),1);
choiceS = zeros(length(taskS),1);
rxnS = zeros(length(taskS),1);
orderS = zeros(length(taskS),1);
choiceC1 = zeros(length(taskC1),1);
rxnC1 = zeros(length(taskC1),1);
orderC1 = zeros(length(taskC1),1);
choiceC2 = zeros(length(taskC2),1);
rxnC2 = zeros(length(taskC2),1);
orderC2 = zeros(length(taskC2),1);
choiceC3 = zeros(length(taskC3),1);
rxnC3 = zeros(length(taskC3),1);
orderC3 = zeros(length(taskC3),1);

for tn=1 : length(trialOrder)
    switch trialOrder(tn)
        case 1 % this means we are dealing with the case that task = treatA trials
            reorder = orderAold(aIndex);
            if choiceA(reorder) == 0
                choiceA(reorder) = choice(tn);
                rxnA(reorder) = behavioralSecs(tn,2);
                orderA(reorder) = tn;
            else
                choiceA(reorder,2) = choice(tn);
                rxnA(reorder,2) = behavioralSecs(tn,2);
                orderA(reorder,2) = tn;
            end
            aIndex = aIndex + 1;
        case 2 % this means we are dealing with the case that task = treatS trials
            reorder = orderSold(sIndex);
            if choiceS(reorder) == 0
                choiceS(reorder) = choice(tn);
                rxnS(reorder) = behavioralSecs(tn,2);
                orderS(reorder) = tn;
            else
                choiceS(reorder,2) = choice(tn);
                rxnS(reorder,2) = behavioralSecs(tn,2);
                orderS(reorder,2) = tn;
            end
            sIndex = sIndex + 1;
        case 3 % this means we are dealing with the case that task = treatC3435 trials
            reorder = orderC1old(c1Index);
            if choiceC1(reorder) == 0
                choiceC1(reorder) = choice(tn);
                rxnC1(reorder) = behavioralSecs(tn,2);
                orderC1(reorder) = tn;
            else
                choiceC1(reorder,2) = choice(tn);
                rxnC1(reorder,2) = behavioralSecs(tn,2);
                orderC1(reorder,2) = tn;
            end
            c1Index = c1Index + 1;
        case 4 % this means we are dealing with the case that task = treatC3445 trials
            reorder = orderC2old(c2Index);
            if choiceC2(reorder) == 0
                choiceC2(reorder) = choice(tn);
                rxnC2(reorder) = behavioralSecs(tn,2);
                orderC2(reorder) = tn;
            else
                choiceC2(reorder,2) = choice(tn);
                rxnC2(reorder,2) = behavioralSecs(tn,2);
                orderC2(reorder,2) = tn;
            end
            c2Index = c2Index + 1;
        case 5 % this means we are dealing with the case that task = treatC3545 trials
            reorder = orderC3old(c3Index);
            if choiceC3(reorder) == 0
                choiceC3(reorder) = choice(tn);
                rxnC3(reorder) = behavioralSecs(tn,2);
                orderC3(reorder) = tn;
            else
                choiceC3(reorder,2) = choice(tn);
                rxnC3(reorder,2) = behavioralSecs(tn,2);
                orderC3(reorder,2) = tn;
            end
            c3Index = c3Index + 1;
    end
end


end




