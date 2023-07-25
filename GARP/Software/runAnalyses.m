
datafolder = ('/Users/Niree/Documents/GARP/GARP_public/Data/records');
addpath /Users/Niree/Documents/GARP/GARP_public/Functions/Post-experiment/Preprocessing
addpath /Users/Niree/Documents/GARP/GARP_public/Functions/Post-experiment/Stats
addpath /Users/Niree/Documents/GARP/GARP_public/Functions/Post-experiment/Strategies
addpath /Users/Niree/Documents/GARP/GARP_public/Functions/Post-experiment/Violation-counting

cd(datafolder);

subjects = dir;          % count all of the subjects in the folder

strategySummary = zeros(length(subjects)+1,11); % prep for later
violationSummary = zeros(length(subjects)+1,8);
severeIndxOmitSummary = zeros(length(subjects)+1,6);
severeIndxCKBavgSummary = zeros(length(subjects)+1,8);
severeIndxCKBminSummary = zeros(length(subjects)+1,8);

for i = 1:length(subjects)
    if subjects(i).name(1) == '.';
        continue
    end
    load(subjects(i).name);
    cd ('../preProcessed');
    folderName = num2str(settings.subjID);
    switch length(folderName)
        case 1
            mkdir(['00' folderName]);
            cd(['00' folderName]);
        case 2
            mkdir(['0' folderName]);
            cd(['0' folderName])
        case 3
            mkdir(folderName);
            cd(folderName);
    end
    
    %% Bring over the tasks from the subject data files
    subjID = settings.subjID;
    taskA = settings.tasksTreatA;
    taskS = settings.tasksTreatS;
    taskC1 = settings.tasksTreatC3435;
    taskC2 = settings.tasksTreatC3445;
    taskC3 = settings.tasksTreatC3545;
    
    %% Change choice labels from letters to numbers
    for press = 1:length(behavioral.key)
        if behavioral.key(press) == 'f';
            if settings.flipLR(press) == 0;
                choice(press) = 1;
            elseif settings.flipLR(press) == 1;
                choice(press) = 2;
            end
        elseif behavioral.key(press) == 'j';
            if settings.flipLR(press) == 0;
                choice(press) = 2;
            elseif settings.flipLR(press) == 1;
                choice(press) = 1;
            end
        end
    end
    
    trialOrder = settings.trialOrder;
    orderAold = settings.orderTreatA;
    orderSold = settings.orderTreatS;
    orderC1old = settings.orderTreatC3435;
    orderC2old = settings.orderTreatC3445;
    orderC3old = settings.orderTreatC3545;
    behavioralSecs = behavioral.secs;
    
     %% Calculate response times
    for j = 1:(length(behavioralSecs(:,1)) - 1)
        behavioralSecs(1,2) = behavioralSecs(1,1); %first trial of 1st block
        behavioralSecs(j+1,2) = behavioralSecs(j+1,1) - behavioralSecs(j,1);
    end
    behavioralSecs(39,2) = behavioralSecs(39,1); %first trial of 2nd block
    behavioralSecs(77,2) = behavioralSecs(77,1); %first trial of 3rd block
    behavioralSecs(115,2) = behavioralSecs(115,1); %first trial of 4th block
    
    preProcessed.behavioralSecs = behavioralSecs;
    
    %% Run pre-processing script
    [choiceA,rxnA,orderA,choiceS,rxnS,orderS,choiceC1,rxnC1,orderC1,...
        choiceC2,rxnC2,orderC2,choiceC3,rxnC3,orderC3] = ...
        preProcess_flipped(taskA,taskS,taskC1,taskC2,taskC3,choice,trialOrder,...
        orderAold,orderSold,orderC1old,orderC2old,orderC3old,behavioralSecs);
    
    %% Standardize choice data structures
    for j = 1:length(taskC1);
        taskRevC1(1,1,j) = taskC1(1,1,j);
        taskRevC1(1,2,j) = taskC1(1,2,j);
        taskRevC1(1,3,j) = 0;
        taskRevC1(2,1,j) = taskC1(2,1,j);
        taskRevC1(2,2,j) = 0;
        taskRevC1(2,3,j) = taskC1(2,2,j);
    end
    
    for j = 1:length(taskC2);
        taskRevC2(1,1,j) = taskC2(1,1,j);
        taskRevC2(1,2,j) = taskC2(1,2,j);
        taskRevC2(1,3,j) = 0;
        taskRevC2(2,1,j) = 0;
        taskRevC2(2,2,j) = taskC2(2,1,j);
        taskRevC2(2,3,j) = taskC2(2,2,j);
    end
    
    for j = 1:length(taskC3);
        taskRevC3(1,1,j) = taskC3(1,1,j);
        taskRevC3(1,2,j) = 0;
        taskRevC3(1,3,j) = taskC3(1,2,j);
        taskRevC3(2,1,j) = 0;
        taskRevC3(2,2,j) = taskC3(2,1,j);
        taskRevC3(2,3,j) = taskC3(2,2,j);
    end
    
    
    %% Count violations
    taskC1 = taskRevC1;
    taskC2 = taskRevC2;
    taskC3 = taskRevC3;
    
    [violationA,...
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
        choiceC3);
    
    [violationSummary] = violationsSummary(i,subjID,violationSummary,...
        violationA,violationCountS,violationCountC1,violationCountC2,...
        violationCountC3,violationCountCI);
    
    [severeIndxOmitSummary,severeIndxCKBavgSummary,severeIndxCKBminSummary] = ...
        severitiesSummary(i,subjID,severeIndxOmitSummary,severeIndxCKBavgSummary,...
        severeIndxCKBminSummary,severeIndxCKBavgS,...
        severeIndxCKBminS,severeIndxS,severeIndxCKBavgC1,...
        severeIndxCKBminC1,severeIndxC1,severeIndxCKBavgC2,...
        severeIndxCKBminC2,severeIndxC2,severeIndxCKBavgC3,...
        severeIndxCKBminC3,severeIndxC3,severeIndxCKBavgCI,...
        severeIndxCKBminCI,severeIndxCI,severeIndxCKBavgAll,...
        severeIndxCKBavgC,severeIndxCKBminAll,severeIndxCKBminC);
    
    %% Change data structure to save into one .mat file
    % Treat A
    preProcessed.treatA.tasks = taskA;
    preProcessed.treatA.choices = choiceA;
    preProcessed.treatA.rxntimes = rxnA;
    preProcessed.treatA.order = orderA;
    violation.violation.treatA.count = violationA;
    
    % Treat S
    preProcessed.treatS.tasks= taskS;
    preProcessed.treatS.choices = choiceS;
    preProcessed.treatS.rxntimes = rxnS;
    preProcessed.treatS.order = orderS;
    violation.severity.CKBavg.treatS.matrix = CKBavgS;
    violation.severity.CKBavg.treatS.index = severeIndxCKBavgS;
    violation.severity.CKBavg.treatS.bychoice = CKBbychoiceS;
    violation.severity.CKBmin.treatS.matrix = CKBminS;
    violation.severity.CKBmin.treatS.index = severeIndxCKBminS;
    violation.severity.omitchoice.treatS.count = severeCountS;
    violation.severity.omitchoice.treatS.fraction = severeFracS;
    violation.severity.omitchoice.treatS.index = severeIndxS;
    violation.violation.treatS.count = violationCountS;
    violation.violation.treatS.bychoice = violationByChoiceS;
    violation.violation.treatS.matrix = violationS;
    
    % Treat C3435
    preProcessed.treatC1.tasks = taskC1;
    preProcessed.treatC1.choices = choiceC1;
    preProcessed.treatC1.rxntimes = rxnC1;
    preProcessed.treatC1.order = orderC1;
    violation.severity.CKBavg.treatC1.matrix = CKBavgC1;
    violation.severity.CKBavg.treatC1.index = severeIndxCKBavgC1;
    violation.severity.CKBavg.treatC1.bychoice = CKBbychoiceC1;
    violation.severity.CKBmin.treatC1.matrix = CKBminC1;
    violation.severity.CKBmin.treatC1.index = severeIndxCKBminC1;
    violation.severity.omitchoice.treatC1.count = severeCountC1;
    violation.severity.omitchoice.treatC1.fraction = severeFracC1;
    violation.severity.omitchoice.treatC1.index = severeIndxC1;
    violation.violation.treatC1.count = violationCountC1;
    violation.violation.treatC1.bychoice = violationByChoiceC1;
    violation.violation.treatC1.matrix = violationC1;
    
    % Treat C3445
    preProcessed.treatC2.tasks = taskC2;
    preProcessed.treatC2.choices = choiceC2;
    preProcessed.treatC2.rxntimes = rxnC2;
    preProcessed.treatC2.order = orderC2;
    violation.severity.CKBavg.treatC2.matrix = CKBavgC2;
    violation.severity.CKBavg.treatC2.index = severeIndxCKBavgC2;
    violation.severity.CKBavg.treatC2.bychoice = CKBbychoiceC2;
    violation.severity.CKBmin.treatC2.matrix = CKBminC2;
    violation.severity.CKBmin.treatC2.index = severeIndxCKBminC2;
    violation.severity.omitchoice.treatC2.count = severeCountC2;
    violation.severity.omitchoice.treatC2.fraction = severeFracC2;
    violation.severity.omitchoice.treatC2.index = severeIndxC2;
    violation.violation.treatC2.count = violationCountC2;
    violation.violation.treatC2.bychoice = violationByChoiceC2;
    violation.violation.treatC2.matrix = violationC2;
    
    % Treat C3545
    preProcessed.treatC3.tasks = taskC3;
    preProcessed.treatC3.choices = choiceC3;
    preProcessed.treatC3.rxntimes = rxnC3;
    preProcessed.treatC3.order = orderC3;
    violation.severity.CKBavg.treatC3.matrix = CKBavgC3;
    violation.severity.CKBavg.treatC3.index = severeIndxCKBavgC3;
    violation.severity.CKBavg.treatC3.bychoice = CKBbychoiceC3;
    violation.severity.CKBmin.treatC3.matrix = CKBminC3;
    violation.severity.CKBmin.treatC3.index = severeIndxCKBminC3;
    violation.severity.omitchoice.treatC3.count = severeCountC3;
    violation.severity.omitchoice.treatC3.fraction = severeFracC3;
    violation.severity.omitchoice.treatC3.index = severeIndxC3;
    violation.violation.treatC3.count = violationCountC3;
    violation.violation.treatC3.bychoice = violationByChoiceC3;
    violation.violation.treatC3.matrix = violationC3;
    
    % Treat C-Indirect
    violation.severity.CKBavg.treatCI.matrix = CKBavgCI;
    violation.severity.CKBavg.treatCI.index = severeIndxCKBavgCI;
    violation.severity.CKBavg.treatCI.bychoice = CKBbychoiceCI;
    violation.severity.CKBmin.treatCI.matrix = CKBminCI;
    violation.severity.CKBmin.treatCI.index = severeIndxCKBminCI;
    violation.severity.omitchoice.treatCI.count = severeCountCI;
    violation.severity.omitchoice.treatCI.fraction = severeFracCI;
    violation.severity.omitchoice.treatCI.index = severeIndxCI;
    violation.violation.treatCI.count = violationCountCI;
    violation.violation.treatCI.bychoice = violationByChoiceCI;
    violation.violation.treatCI.matrix = violationCI;
    
    %% Check for heuristics
    [strategyDeviationS,heuristicS,strategySequenceS,myStrategySequenceS,...
        strategyDeviationC1,heuristicC1,strategySequenceC1,myStrategySequenceC1,...
        strategyDeviationC2,heuristicC2,strategySequenceC2,myStrategySequenceC2,...
        strategyDeviationC3,heuristicC3,strategySequenceC3,myStrategySequenceC3] = ...
        strategies(taskS,choiceS,taskC1,choiceC1,taskC2,...
        choiceC2,taskC3,choiceC3);
    
    % Estimate value parameters
    % For Treat S
    [ y_outputS,y_maxS,p_outputS,bestPS,bestQS,bestValueS,bestLLS,...
        utilitiesS,mystrategyUMAXS,strategyUMAXdeviationS] = ...
        fminTreatS(taskS,choiceS);
    
    % For Treat C
    [ y_outputC,y_maxC,p_outputC,bestPC,bestQC,bestValueC,bestLLC,...
        utilitiesC,mystrategyUMAXC,strategyUMAXdeviationC] = ...
        fminTreatC(taskC1,taskC2,taskC3,choiceC1,choiceC2,choiceC3);
    
    [ strategySummary ] = ...
        strategiesSummary( i,subjID,strategySummary,strategyDeviationS,strategyUMAXdeviationS,...
        strategyDeviationC1,strategyDeviationC2,strategyDeviationC3,...
        strategyUMAXdeviationC);
    
    strategy.treatS.deviations = strategyDeviationS;
    strategy.treatS.heuristic = heuristicS;
    strategy.treatS.sequence = strategySequenceS;
    strategy.treatS.mysequence = myStrategySequenceS;
    strategy.treatC1.deviations = strategyDeviationC1;
    strategy.treatC1.heuristic = heuristicC1;
    strategy.treatC1.sequence = strategySequenceC1;
    strategy.treatC1.mysequence = myStrategySequenceC1;
    strategy.treatC2.deviations = strategyDeviationC2;
    strategy.treatC2.heuristic = heuristicC2;
    strategy.treatC2.sequence = strategySequenceC2;
    strategy.treatC2.mysequence = myStrategySequenceC2;
    strategy.treatC3.deviations = strategyDeviationC3;
    strategy.treatC3.heuristic = heuristicC3;
    strategy.treatC3.sequence = strategySequenceC3;
    strategy.treatC3.mysequence = myStrategySequenceC3;
    
    preProcessed.subjID = subjID;
    
    save('strategy.mat','strategy');
    save('violation.mat','violation');
    save('preProcessed.mat','preProcessed');
    
    
    %% Move back to correct folder
    cd('../');
    cd(datafolder);
    clearvars -except i strategySummary violationSummary severeIndxOmitSummary severeIndxCKBavgSummary severeIndxCKBminSummary subjects datafolder
end

cd('../');
cd('preProcessed');

subLength = length(dir) - 2; % subtract 2 'extra' elements, which exist in any given directory
v = (4:subLength+3);
treatS(1:subLength,1:5) = cat(2,strategySummary(v,2:5),strategySummary(v,8));
treatC(1:subLength,1:6) = cat(2,strategySummary(v,9:12),strategySummary(v,14),strategySummary(v,19));
bothTreats(1:subLength,1:8) = cat(2,strategySummary(v,20:23),strategySummary(v,25:27),strategySummary(v,32));
for j = 1:3
    [MLEoutput] = MLE(j,treatS,treatC,bothTreats);
    if j == 1
        MLEstrategySummary.treatS(:,1) = MLEoutput.maxType;
        MLEstrategySummary.treatS(:,2) = MLEoutput.probaMaxType;
        MLEoutputS = MLEoutput; % the full MLE output does not get saved as the script is written. changet the line to MLESummary.MLEoutput = MLEoutput to have it saved
    elseif j == 2
        MLEstrategySummary.treatC(:,1) = MLEoutput.maxType;
        MLEstrategySummary.treatC(:,2) = MLEoutput.probaMaxType;
        MLEoutputC = MLEoutput;
    elseif j == 3
        MLEstrategySummary.treatAll(:,1) = MLEoutput.maxType;
        MLEstrategySummary.treatAll(:,2) = MLEoutput.probaMaxType;
        MLEoutputAll = MLEoutput;
    end
    clearvars -except j MLEstrategySummary treatS treatC bothTreats violationSummary severeIndxOmitSummary severeIndxCKBavgSummary severeIndxCKBminSummary strategySummary severitySummary
end

severitySummary.severeIndxOmitSummary = severeIndxOmitSummary;
severitySummary.severeIndxCKBavgSummary = severeIndxCKBavgSummary;
severitySummary.severeIndxCKBminSummary = severeIndxCKBminSummary;

save ('MLEstrategySummary.mat', 'MLEstrategySummary');
save('strategySummary.mat','strategySummary');
save('violationSummary.mat','violationSummary');
save('severitySummary.mat','severitySummary');

clear all

