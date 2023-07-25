function[violationA,...
    CKBavgS,CKBminS,CKBbychoiceS,violationS,violationCountS,...
    severeIndxCKBavgS,severeIndxCKBminS,violationByChoiceS,severeFracS,...
    severeCountS,severeIndxS,...
    CKBavgC1,CKBminC1,CKBbychoiceC1,violationC1,violationCountC1,...
    severeIndxCKBavgC1,severeIndxCKBminC1,violationByChoiceC1,severeFracC1,...
    severeCountC1,severeIndxC1,...
    CKBavgC2,CKBminC2,CKBbychoiceC2,violationC2,violationCountC2,...
    severeIndxCKBavgC2,severeIndxCKBminC2,violationByChoiceC2,severeFracC2,...
    severeCountC2,severeIndxC2,...
    CKBavgC3,CKBminC3,CKBbychoiceC3,violationC3,violationCountC3,...
    severeIndxCKBavgC3,severeIndxCKBminC3,violationByChoiceC3,severeFracC3,...
    severeCountC3,severeIndxC3,...
    CKBavgCI,CKBminCI,CKBbychoiceCI,violationCI,violationCountCI,...
    severeIndxCKBavgCI,severeIndxCKBminCI,violationByChoiceCI,severeFracCI,...
    severeCountCI,severeIndxCI,...
    severeIndxCKBavgAll,severeIndxCKBavgC,severeIndxCKBminAll,severeIndxCKBminC]...
    = violationCounter(taskA, choiceA, taskS,...
    choiceS, taskC1, choiceC1, taskC2, choiceC2, taskC3,...
    choiceC3)

% Description: this script calls on subscripts that count violations (i.e.
% threeItemGARP1213ViolationCounter.m) as well as subscripts designed to
% count the number of choice removals necessary to obtain perfect
% consistency (i.e. twoItemGARPChoiceOmit.m). The script creates several
% .mat files for each subject containing their violation counts, choice
% removals for consistency, and CKB severity index, all by task type.


%% Treat A violation counter
set = taskA; 
choice = choiceA;
[violation] = catchViolationCounter(set,choice);
violationA = violation;

%% Treat S violation counter
set = taskS;
choice = choiceS;
[violation, violationbychoice, CKB, CKBmin, CKBbychoice] = twoItemGARPViolationCounter(set,choice);

if nnz(CKB) ~= 0
    severeIndxCKBavgS = sum(sum(CKB))/nnz(CKB);
    severeIndxCKBminS = sum(sum(CKBmin))/nnz(CKBmin);
else
    severeIndxCKBavgS = 0;
    severeIndxCKBminS = 0;
end

CKBavgS = CKB;
CKBminS = CKBmin;
CKBbychoiceS = CKBbychoice;

[maxes] = twoItemGARPChoiceOmit(violation, violationbychoice, set);
violationS = violation;
violationCountS = nnz(violationS)/2;
violationByChoiceS = violationbychoice;

denom = violationCountS;

% Calculates level of consistency with each sequential violating-choice
% omission, where a value of 1 corresponds to perfect consistency
severeFracS(1,1) = denom;
severeFracS(1,2) = maxes(1)/denom; 
for i = 2:20
    index = i - 1;
    severeFracS(1,i) = severeFracS(1,index) + maxes(i)/denom;
end

% Calculates number of violations remaining with each sequential
% violating-choice omission, where a value of 0 corresponds to perfect
% consistency 
severeCountS(1,1) = denom;
severeCountS(1,2) = denom - maxes(1);
for i = 3:21
    index = i - 1;
    severeCountS(1,i) = severeCountS(1,index) - maxes(index);
end

% Using the second measure of severity (although both produce the same
% number), counts the number of choices to be removed to achieve perfect
% consistency
i = 1;
while i < 22
    if (i == 1) && (severeCountS(1,i) == 0);
        severeIndxS = 0;
        i = 22;
    elseif (i ~= 1) && (severeCountS(1,i) == 0);
        severeIndxS = i - 1;
        i = 22;
    elseif severeCountS(1,i) ~= 0;
        severeIndxS = i;
    end
    i = i + 1;
end

%% Treat C 3435 violation counter
set = taskC1;
choice = choiceC1;
[violation, violationbychoice, CKB, CKBmin, CKBbychoice] = threeItemGARP1213ViolationCounter(set,choice);

if nnz(CKB) ~= 0
    severeIndxCKBavgC1 = sum(sum(CKB))/nnz(CKB);
    severeIndxCKBminC1 = sum(sum(CKBmin))/nnz(CKBmin);
else
    severeIndxCKBavgC1 = 0;
    severeIndxCKBminC1 = 0;
end

CKBavgC1 = CKB;
CKBminC1 = CKBmin;
CKBbychoiceC1 = CKBbychoice;

[maxes] = threeItemGARP3435ChoiceOmit(violation, violationbychoice, set);
violationC1 = violation;
violationCountC1 = nnz(violationC1)/2;
violationByChoiceC1 = violationbychoice;

denom = violationCountC1;

% Calculates level of consistency with each sequential violating-choice
% omission, where a value of 1 corresponds to perfect consistency
severeFracC1(1,1) = denom;
severeFracC1(1,2) = maxes(1)/denom; 
for i = 2:20
    index = i - 1;
    severeFracC1(1,i) = severeFracC1(1,index) + maxes(i)/denom;
end

% Calculates number of violations remaining with each sequential
% violating-choice omission, where a value of 0 corresponds to perfect
% consistency 
severeCountC1(1,1) = denom;
severeCountC1(1,2) = denom - maxes(1);
for i = 3:21
    index = i - 1;
    severeCountC1(1,i) = severeCountC1(1,index) - maxes(index);
end

% Using the second measure of severity (although both produce the same
% number), counts the number of choices to be removed to achieve perfect
% consistency
i = 1;
while i < 22
    if (i == 1) && (severeCountC1(1,i) == 0);
        severeIndxC1 = 0;
        i = 22;
    elseif (i ~= 1) && (severeCountC1(1,i) == 0);
        severeIndxC1 = i - 1;
        i = 22;
    elseif severeCountC1(1,i) ~= 0;
        severeIndxC1 = i;
    end
    i = i + 1;
end

%% Treat C 3445 violation counter
set = taskC2;
choice = choiceC2;
[violation, violationbychoice, CKB, CKBmin, CKBbychoice] = threeItemGARP1223ViolationCounter(set,choice);

if nnz(CKB) ~= 0
    severeIndxCKBavgC2 = sum(sum(CKB))/nnz(CKB);
    severeIndxCKBminC2 = sum(sum(CKBmin))/nnz(CKBmin);
else
    severeIndxCKBavgC2 = 0;
    severeIndxCKBminC2 = 0;
end

CKBavgC2 = CKB;
CKBminC2 = CKBmin;
CKBbychoiceC2 = CKBbychoice;

[maxes] = threeItemGARP3445ChoiceOmit(violation, violationbychoice, set);
violationC2 = violation;
violationCountC2 = nnz(violationC2)/2;
violationByChoiceC2 = violationbychoice;

denom = violationCountC2;

% Calculates level of consistency with each sequential violating-choice
% omission, where a value of 1 corresponds to perfect consistency
severeFracC2(1,1) = denom;
severeFracC2(1,2) = maxes(1)/denom; 
for i = 2:20
    index = i - 1;
    severeFracC2(1,i) = severeFracC2(1,index) + maxes(i)/denom;
end

% Calculates number of violations remaining with each sequential
% violating-choice omission, where a value of 0 corresponds to perfect
% consistency 
severeCountC2(1,1) = denom;
severeCountC2(1,2) = denom - maxes(1);
for i = 3:21
    index = i - 1;
    severeCountC2(1,i) = severeCountC2(1,index) - maxes(index);
end

% Using the second measure of severity (although both produce the same
% number), counts the number of choices to be removed to achieve perfect
% consistency
i = 1;
while i < 22
    if (i == 1) && (severeCountC2(1,i) == 0);
        severeIndxC2 = 0;
        i = 22;
    elseif (i ~= 1) && (severeCountC2(1,i) == 0);
        severeIndxC2 = i - 1;
        i = 22;
    elseif severeCountC2(1,i) ~= 0;
        severeIndxC2 = i;
    end
    i = i + 1;
end

%% Treat C 3545 violation counter
set = taskC3;
choice = choiceC3;
[violation, violationbychoice, CKB, CKBmin, CKBbychoice] = threeItemGARP1323ViolationCounter(set,choice);

if nnz(CKB) ~= 0
    severeIndxCKBavgC3 = sum(sum(CKB))/nnz(CKB);
    severeIndxCKBminC3 = sum(sum(CKBmin))/nnz(CKBmin);
else
    severeIndxCKBavgC3 = 0;
    severeIndxCKBminC3 = 0;
end

CKBavgC3 = CKB;
CKBminC3 = CKBmin;
CKBbychoiceC3 = CKBbychoice;

[maxes] = threeItemGARP3545ChoiceOmit(violation, violationbychoice, set);
violationC3 = violation;
violationCountC3 = nnz(violationC3)/2;
violationByChoiceC3 = violationbychoice;

denom = violationCountC3;

% Calculates level of consistency with each sequential violating-choice
% omission, where a value of 1 corresponds to perfect consistency
severeFracC3(1,1) = denom;
severeFracC3(1,2) = maxes(1)/denom; 
for i = 2:20
    index = i - 1;
    severeFracC3(1,i) = severeFracC3(1,index) + maxes(i)/denom;
end

% Calculates number of violations remaining with each sequential
% violating-choice omission, where a value of 0 corresponds to perfect
% consistency 
severeCountC3(1,1) = denom;
severeCountC3(1,2) = denom - maxes(1);
for i = 3:21
    index = i - 1;
    severeCountC3(1,i) = severeCountC3(1,index) - maxes(index);
end

% Using the second measure of severity (although both produce the same
% number), counts the number of choices to be removed to achieve perfect
% consistency
i = 1;
while i < 22
    if (i == 1) && (severeCountC3(1,i) == 0);
        severeIndxC3 = 0;
        i = 22;
    elseif (i ~= 1) && (severeCountC3(1,i) == 0);
        severeIndxC3 = i - 1;
        i = 22;
    elseif severeCountC3(1,i) ~= 0;
        severeIndxC3 = i;
    end
    i = i + 1;
end

%% Treat C indirect violation counter
set1 = taskC1;
choice1 = choiceC1;
set2 = taskC2;
choice2 = choiceC2;
set3 = taskC3;
choice3 = choiceC3;

[violation, violationbychoice, CKB, CKBmin, CKBbychoice] = threeItemCyclicalViolationCounter(set1, choice1, set2, choice2, set3, choice3);

if nnz(CKB) ~= 0
    severeIndxCKBavgCI = sum(sum(sum(CKB)))/nnz(CKB);
    severeIndxCKBminCI = sum(sum(sum(CKBmin)))/nnz(CKBmin);
else
    severeIndxCKBavgCI = 0;
    severeIndxCKBminCI = 0;
end

CKBavgCI = CKB;
CKBminCI = CKBmin;
CKBbychoiceCI = CKBbychoice;

[maxes] = threeItemCyclicalChoiceOmit( violation, violationbychoice, set1, choice1, set2, choice2, set3, choice3 );
violationCI = violation;
violationCountCI = nnz(violationCI);
violationByChoiceCI = violationbychoice;

denom = violationCountCI; 

% Calculates level of consistency with each sequential violating-choice
% omission, where a value of 1 corresponds to perfect consistency
severeFracCI(1,1) = denom;
severeFracCI(1,2) = maxes(1)/denom; 
for i = 2:20
    index = i - 1;
    severeFracCI(1,i) = severeFracCI(1,index) + maxes(i)/denom;
end

% Calculates number of violations remaining with each sequential
% violating-choice omission, where a value of 0 corresponds to perfect
% consistency 
severeCountCI(1,1) = denom;
severeCountCI(1,2) = denom - maxes(1);
for i = 3:21
    index = i - 1;
    severeCountCI(1,i) = severeCountCI(1,index) - maxes(index);
end

% Using the second measure of severity (although both produce the same
% number), counts the number of choices to be removed to achieve perfect
% consistency
i = 1;
while i < 22
    if (i == 1) && (severeCountCI(1,i) == 0);
        severeIndxCI = 0;
        i = 22;
    elseif (i ~= 1) && (severeCountCI(1,i) == 0);
        severeIndxCI = i - 1;
        i = 22;
    elseif severeCountCI(1,i) ~= 0;
        severeIndxCI = i;
    end
    i = i + 1;
    
   %% 
   % For CKB with average distance
a1 = sum(sum(CKBavgS)); % to determine the numerators
b1 = sum(sum(CKBavgC1));
c1 = sum(sum(CKBavgC2));
d1 = sum(sum(CKBavgC3));
e1 = sum(sum(sum(CKBavgCI)));
matrixAll1 = [a1, b1, c1, d1, e1];
sumAll1 = sum(matrixAll1);
matrixTreatCtotal1 = [b1, c1, d1, e1];
sumTreatCtotal1 = sum(matrixTreatCtotal1);

a2 = nnz(CKBavgS); % to determine the denominators (i.e. how many choices caused violations, and in turn, have a corresponding severity value)
b2 = nnz(CKBavgC1);
c2 = nnz(CKBavgC2);
d2 = nnz(CKBavgC3);
e2 = nnz(CKBavgCI);
matrixAll2 = [a2, b2, c2, d2, e2];
sumAll2 = sum(matrixAll2);
matrixTreatCtotal2 = [b2, c2, d2, e2];
sumTreatCtotal2 = sum(matrixTreatCtotal2);
if sumAll2 == 0
    severeIndxCKBavgAll = 0;
else 
    severeIndxCKBavgAll = sumAll1/sumAll2;
end

if sumTreatCtotal2 == 0
    severeIndxCKBavgC = 0;
else
    severeIndxCKBavgC = sumTreatCtotal1/sumTreatCtotal2;
end

% For CKB with minimum distance
aa1 = sum(sum(CKBminS)); % to determine the numerators
bb1 = sum(sum(CKBminC1));
cc1 = sum(sum(CKBminC2));
dd1 = sum(sum(CKBminC3));
ee1 = sum(sum(sum(CKBminCI)));
matrixAllMIN1 = [aa1, bb1, cc1, dd1, ee1];
sumAllMIN1 = sum(matrixAllMIN1);
matrixTreatCtotalMIN1 = [bb1, cc1, dd1, ee1];
sumTreatCtotalMIN1 = sum(matrixTreatCtotalMIN1);

aa2 = nnz(CKBminS); % to determine the denominators (i.e. how many choices caused violations, and in turn, have a corresponding severity value)
bb2 = nnz(CKBminC1);
cc2 = nnz(CKBminC2);
dd2 = nnz(CKBminC3);
ee2 = nnz(CKBminCI);
matrixAllMIN2 = [aa2, bb2, cc2, dd2, ee2];
sumAllMIN2 = sum(matrixAllMIN2);
matrixTreatCtotalMIN2 = [bb2, cc2, dd2, ee2];
sumTreatCtotalMIN2 = sum(matrixTreatCtotalMIN2);
if sumAllMIN2 == 0
    severeIndxCKBminAll = 0;
else 
    severeIndxCKBminAll = sumAllMIN1/sumAllMIN2;
end

if sumTreatCtotalMIN2 == 0
    severeIndxCKBminC = 0;
else
    severeIndxCKBminC = sumTreatCtotalMIN1/sumTreatCtotalMIN2;
end

end

