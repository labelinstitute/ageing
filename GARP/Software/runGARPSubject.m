function [] = runGARPSubject( subjID, item1c, item2c, item3c, item4c, item5c, input )
% The first input 'subjID' is the subject ID number
% The next 5 inputs are the five items the subject is to choose amongst during
% the couse of the experiment
% The input called 'input' identifies whether a keyboard ('k'), a mouse
% ('m'), or a windows 8 tablet ('t') will be used

% Change these paths to specify the location on your computer where the
% GARP_public folder is saved
addpath /Users/Niree/Documents/GARP/GARP_public/Sets
addpath /Users/Niree/Documents/GARP/GARP_public/Functions/During-experiment
addpath /Users/Niree/Documents/GARP/GARP_public/Images
addpath /Users/Niree/Documents/GARP/GARP_public/SSTM
datafolder = ('/Users/Niree/Documents/GARP/GARP_public/Data');

%% Defaults
% Defaults are specified ONLY for the purpose of testing the script,
% directly from the Editor window

% Default for 'subjID' is 1. This only kicks in if subject ID is left
% unspecified
if exist('subjID','var') == 0;
    subjID = 1;
end

% Default for 'input' is 'k'. Again, this only kicks in if the 7th input
% variable is left unspecified
if exist('input','var') == 0;
    input = 'k';
end

% Default items. These only kick in if the item inputs are left unspecified
if exist('item1c','var') == 0; item1c = 1; end
if exist('item2c','var') == 0; item2c = 2; end
if exist('item3c','var') == 0; item3c = 3; end
if exist('item4c','var') == 0; item4c = 4; end
if exist('item5c','var') == 0; item5c = 5; end

%% Settings 
% In the case that 'input' is 't', we need to disable the screen sync test
if input == 't';
    Screen('preference', 'SkipSyncTests',1);
end

% Load all of the task lists
load('setTreatA.mat'); % List for attention (treatment A) trials. This is a 10x2 list, where each row corresponds to one attention trial. Numbers refer to the items that will be compared during a given trial.
load('setTreatSC.mat'); % This is a 3D array of size 2x2x35. Each (1:2,1:2,x) set corresponds to a single GARP presentation. Numbers refer to the items that will be compared during a given trial.


tasksTreatA = setTreatA;
tasksTreatS = setTreatSC; % 'setTreatSC.mat' will be used for treatment S ...
tasksTreatC3435 = setTreatSC; % ... as well as for the three types of treatment C
tasksTreatC3445 = setTreatSC;
tasksTreatC3545 = setTreatSC;

%% Design the task orders
trials = [1*ones(1,length(tasksTreatA)), 2*ones(1,length(tasksTreatS)), 3*ones(1,length(tasksTreatC3435)), 4*ones(1,length(tasksTreatC3445)), 5*ones(1,length(tasksTreatC3545))]; % This creates a 1x150 vector of 1's, 2's, 3's, 4's, and 5's
long = length(trials); % The length of the vector 'trials' or total number of trials that will be performed (in our case this is 150)
trialOrder = trials(randperm(long)); % Create the random order in which trials of different treatments will be presented
blockLength = 38; % Experiment will be separated into four blocks, each of length 38 trials

% Determine the random order in which trials of different treatments will
% be presented
orderTreatA = randperm(length(tasksTreatA)); % The fixed random order in which treatment A trials will be presented
orderTreatS = randperm(length(tasksTreatS)); %The fixed random order in which treatment S trials will be presented
orderTreatC3435 = randperm(length(tasksTreatC3435)); %The fixed random order in which treatment C) trials (3 4 vs 3 5) will be presented
orderTreatC3445 = randperm(length(tasksTreatC3445)); %The fixed random order in which treatment C trials (3 4 vs 4 5) will be presented
orderTreatC3545 = randperm(length(tasksTreatC3545)); %The fixed random order in which treatment C trials (3 5 vs 4 5) will be presented

% Determine the right-left flipping sequence for the experiment. This is so
% that the same bundles do not show up on the same side of the screen for
% all subjects. 0 = not flipped, 1 = flipped
flipLR = [zeros(1,ceil(long/2)), ones(1,floor(long/2))];
flipLR = flipLR(randperm(long));

%% Pick the items (randomly assign items to the different treatments)
items = [item1c item2c item3c item4c item5c];

% Randomly assign items to five numbers (e.g. item1c -> Item4.jpg, item2c
% -> Item2.jpg, item3c -> Item5.jpg, item4c -> Item3.jpg, item5c ->
% Item1.jpg)
% itemOrder = randperm(5);
% for i = 1:5;
%     j = itemOrder(i);
%     v = genvarname(strcat('item', num2str(i)));
%     eval([v '= imread(strcat(''Image'', num2str(items(j)), ''.JPG''));']);
% end

% Do not randomly assign items, but assign them to numbers 1:5 as they are
% listed in command line (item1c -> Item1.jpg, item2c -> Item2.jpg,
% item3c -> Item3.jpg, item4c -> Item4.jpg, item5c -> Item5.jpg)
itemOrder = [1 2 3 4 5];
for i = 1:5;
    j = itemOrder(i);
    v = genvarname(strcat('item', num2str(i)));
    eval([v '= imread(strcat(''Image'', num2str(items(j)), ''.JPG''));']);
end

attnItems = [item1c item1c item2c item2c item3c item3c item4c item4c item5c item5c];
attnItems = attnItems(randperm(10));

%% Set up the screen
screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);
w = Screen('OpenWindow', screenNumber,[],[],[],[]);

%% Save the settings
settings.recordfolder = 'records';
settings.subjID = subjID;
settings.trialOrder = trialOrder;
settings.flipLR = flipLR;
settings.tasksTreatA = tasksTreatA;
settings.orderTreatA = orderTreatA;
settings.attnItems = attnItems;
settings.tasksTreatS = tasksTreatS;
settings.orderTreatS = orderTreatS;
settings.tasksTreatC3435 = tasksTreatC3435;
settings.orderTreatC3435 = orderTreatC3435;
settings.tasksTreatC3445 = tasksTreatC3445;
settings.orderTreatC3445 = orderTreatC3445;
settings.tasksTreatC3545 = tasksTreatC3545;
settings.orderTreatC3545 = orderTreatC3545;

settings.item1 = item1;
settings.item2 = item2;
settings.item3 = item3;
settings.item4 = item4;
settings.item5 = item5;

settings.screenNumber = screenNumber;
settings.width = width;
settings.height = height;

% If the 'records' folder doesn't exist, create it
cd(datafolder);
mkdir(settings.recordfolder);

% Create the file name for this run of this subject
recordname = [settings.recordfolder '/' num2str(subjID) '_' datestr(now,'yyyymmddTHHMMSS') '.mat'];

% Save the settings (the behavioral results are saved later)
save (recordname, 'settings')

% Restrict the keys that can be used for the Kb commands [WARNING: all keys
% are enabled after a 'clear all' command]
if (ismac)
    RestrictKeysForKbCheck([9, 13, 41]) % These are the Mac key codes for f, j, and 'esc' respectively
    escKey = KbName('ESCAPE');
else
    RestrictKeysForKbCheck([70, 74, 81]) % These are the PC keys for f, j and q
    escKey = KbName('Esc');
end

% Display the 'Wait for instructions...' screen
drawStart(w);
Screen('Flip',w);
if input == 'k';
    KbWait([], 3);
elseif input == 'm';
    GetClicks(w,0);
elseif input == 't';
    SetMouse(width/2, height/2 ,w);
    while true;
        [x,y] = GetMouse(w);
        if x ~= width/2 && y ~= height/2;
            break;
        end
    end
end

%% **During the experiment**
% Be mindful that only the "behavioral." data structure will be saved

% Determine the randomly-selected reward trial
rewardTrial = randi(long);

% Set all of the indeces equal to 1 at first
i = 1;
indexTreatA = 1;
indexTreatS =1;
indexTreatC3435 = 1;
indexTreatC3445 = 1;
indexTreatC3545 = 1;
block = 1;

while i <= long;
    
    switch(trialOrder(i));
        case 1 % Treatment A
            item = imread(strcat('Image', num2str(attnItems(indexTreatA)), '.JPG'));
            if flipLR(i) == 0; % don't flip the presentation
                renderGARP(item, item, item, item, ...
                    tasksTreatA(orderTreatA(indexTreatA),1),0, ...
                    tasksTreatA(orderTreatA(indexTreatA),2),0,w);
            elseif flipLR(i) == 1; % flip the presentation
                renderGARP(item, item, item, item, ...
                    tasksTreatA(orderTreatA(indexTreatA),2),0, ...
                    tasksTreatA(orderTreatA(indexTreatA),1),0,w);
            end
            indexTreatA = indexTreatA  + 1 ;
            
            
        case 2 % Treatment S (items 1 and 2 vs. items 1 and 2)
            if flipLR(i) == 0; % don't flip the presentation
                renderGARP(item1, ...
                    item2, ...
                    item1, ...
                    item2, ...
                    tasksTreatS(1,1,orderTreatS(indexTreatS)), ...
                    tasksTreatS(1,2,orderTreatS(indexTreatS)), ...
                    tasksTreatS(2,1,orderTreatS(indexTreatS)), ...
                    tasksTreatS(2,2,orderTreatS(indexTreatS)),w);
            elseif flipLR(i) == 1; % flip the presentation
                renderGARP(item1, ...
                    item2, ...
                    item1, ...
                    item2, ...
                    tasksTreatS(2,1,orderTreatS(indexTreatS)), ...
                    tasksTreatS(2,2,orderTreatS(indexTreatS)), ...
                    tasksTreatS(1,1,orderTreatS(indexTreatS)), ...
                    tasksTreatS(1,2,orderTreatS(indexTreatS)),w);
            end
            indexTreatS = indexTreatS  + 1;
            
        case 3 % Treatment C 3435 (items 3 and 4 vs. items 3 and 5)
            if flipLR(i) == 0 % don't flip the presentation
                renderGARP(item3, ...
                    item4, ...
                    item3, ...
                    item5, ...
                    tasksTreatC3435(1,1,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(1,2,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(2,1,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(2,2,orderTreatC3435(indexTreatC3435)),w);
            elseif flipLR(i) == 1 % flip the presentation
                renderGARP(item3, ...
                    item5, ...
                    item3, ...
                    item4, ...
                    tasksTreatC3435(2,1,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(2,2,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(1,1,orderTreatC3435(indexTreatC3435)), ...
                    tasksTreatC3435(1,2,orderTreatC3435(indexTreatC3435)),w);
            end
            indexTreatC3435 = indexTreatC3435  + 1;
            
        case 4 % Treatment C 3445 (items 3 and 4 vs. items 4 and 5)
            if flipLR(i) == 0 % don't flip the presentation
                renderGARP(item3, ...
                    item4, ...
                    item4, ...
                    item5, ...
                    tasksTreatC3445(1,1,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(1,2,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(2,1,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(2,2,orderTreatC3445(indexTreatC3445)),w);
            elseif flipLR(i) == 1 % flip the presentation
                renderGARP(item4, ...
                    item5, ...
                    item3, ...
                    item4, ...
                    tasksTreatC3445(2,1,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(2,2,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(1,1,orderTreatC3445(indexTreatC3445)), ...
                    tasksTreatC3445(1,2,orderTreatC3445(indexTreatC3445)),w);
            end
            indexTreatC3445 = indexTreatC3445  + 1;
            
        case 5 % Treatment C 3545 (items 3 and 5 vs. items 4 and 5)
            if flipLR(i) == 0 % don't flip the presentation
                renderGARP(item3, ...
                    item5, ...
                    item4, ...
                    item5, ...
                    tasksTreatC3545(1,1,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(1,2,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(2,1,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(2,2,orderTreatC3545(indexTreatC3545)),w);
            elseif flipLR(i) == 1 % flip the presentation
                renderGARP(item4, ...
                    item5, ...
                    item3, ...
                    item5, ...
                    tasksTreatC3545(2,1,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(2,2,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(1,1,orderTreatC3545(indexTreatC3545)), ...
                    tasksTreatC3545(1,2,orderTreatC3545(indexTreatC3545)),w);
            end
            indexTreatC3545 = indexTreatC3545  + 1;
    end
    
    if i > 1; % For the 2nd lap and on
        WaitSecs(0.25); % Give time for the key to be released
    end
    [~, StimulusOnsetTime, ~] = Screen('Flip',w);
        
    if input  == 'k'; % If the experiment is done with a keyboard
        [behavioral.secs(i,1), keyCode, behavioral.deltaSecs] = KbWait([], 3);
        drawFixation(w);
        % If a key is pressed, record which key was pressed
        if sum(keyCode) == 1;
            behavioral.key(i,1) = KbName(keyCode);
        end
        behavioral.secs(i,1) = behavioral.secs(i,1) - StimulusOnsetTime;
        
    elseif input == 'm'; % If the experiment is done with a mouse
        [~,x,~,~] = GetClicks(w,0);
        drawFixation(w);
        % If the mouse is clicked, record which side of the screen was clicked
        if x <= width/2;
            behavioral.key(i,1) = 'f';
        elseif x > width/2;
            behavioral.key(i,1) = 'j';
        end
        behavioral.secs(i,1) = GetSecs - StimulusOnsetTime;
        
    elseif input == 't'; % If the experiment is done on a touch-screen tablet
        SetMouse(width/2, height/2 ,w);
        while true;
            [x,y] = GetMouse(w);
            if x ~= width/2 && y ~= height/2;
                break;
            end
        end
        behavioral.secs(i,1) = GetSecs - StimulusOnsetTime;
        drawFixation(w);
        % If the screen is touched, record which side of the screen was
        % touched
        if x <= width/2;
            behavioral.key(i,1) = 'f';
        elseif x > width/2
            behavioral.key(i,1) = 'j';
        end
        
    end
    
    
    %% Identify and save random reward
    if i == rewardTrial;
        
        if trialOrder(i) == 1; % For Treatment A
            left.Item  = attnItems(indexTreatA);
            left.Amount = tasksTreatA(orderTreatA(indexTreatA),1);
            
            right.Item = attnItems(indexTreatA);
            right.Amount = tasksTreatA(orderTreatA(indexTreatA),2);
        end
        
        
        if trialOrder(i) == 2; % For Treatment S
            left.Item = [item1c,item2c];
            left.Amount = [tasksTreatS(1,1,orderTreatS(indexTreatS)), ...
                tasksTreatS(1,2,orderTreatS(indexTreatS))];
            right.Item = [item1c,item2c];
            right.Amount = [tasksTreatS(2,1,orderTreatS(indexTreatS)), ...
                tasksTreatS(2,2,orderTreatS(indexTreatS))];
        end
        
        if trialOrder(i) == 3; % For Treatment C 3435
            left.Item = [item3c,item4c];
            left.Amount = [tasksTreatC3435(1,1,orderTreatC3435(orderTreatC3435)), ...
                tasksTreatC3435(1,2,orderTreatC3435(orderTreatC3435))];
            right.Item = [item3c,item5c];
            right.Amount = [tasksTreatC3435(2,1,orderTreatC3435(orderTreatC3435)), ...
                tasksTreatC3435(2,2,orderTreatC3435(orderTreatC3435))];
        end
        
        if trialOrder(i) == 4; % For Treatment C 3445
            left.Item = [item3c,item4c];
            left.Amount = [tasksTreatC3445(1,1,orderTreatC3445(orderTreatC3445)), ...
                tasksTreatC3445(1,2,orderTreatC3445(orderTreatC3445))];
            right.Item = [item4c,item5c];
            right.Amount = [tasksTreatC3445(2,1,orderTreatC3445(orderTreatC3445)), ...
                tasksTreatC3445(2,2,orderTreatC3445(orderTreatC3445))];
        end
        
        if trialOrder(i) == 5; % For Treatment C 3545
            left.Item = [item3c,item5c];
            left.Amount = [tasksTreatC3545(1,1,orderTreatC3545(orderTreatC3545)), ...
                tasksTreatC3545(1,2,orderTreatC3545(orderTreatC3545))];
            right.Item = [item4c,item5c];
            right.Amount = [tasksTreatC3545(2,1,orderTreatC3545(orderTreatC3545)), ...
                tasksTreatC3545(2,2,orderTreatC3545(orderTreatC3545))];
        end
        
        % Take into account which side was chosen and whether there was a
        % left-right flip for the reward trial
        if behavioral.key(i) == 'f';
            if flipLR(i) == 0;
                reward.Item   = left.Item;
                reward.Amount = left.Amount;
            elseif flipLR(i) == 1;
                reward.Item   = right.Item;
                reward.Amount = right.Amount;
            end
        elseif behavioral.key(i) == 'j';
            if flipLR(i) == 0;
                reward.Item   = right.Item;
                reward.Amount = right.Amount;
            elseif flipLR(i) == 1;
                reward.Item   = left.Item;
                reward.Amount = left.Amount;
            end
        end
        
        save (recordname, 'reward', '-append');
    end
    %% Give a break between blocks
    
    if mod(i,blockLength) == 0; % Throw up the "Break" screen between blocks
        drawBreak(w);
        Screen('Flip',w);
        WaitSecs(20);
        if input == 'k';
            KbWait([], 3);
        elseif input == 'm';
            GetClicks(w,0);
        elseif input == 't';
            SetMouse(width/2, height/2 ,w);
            while true;
                [x,y] = GetMouse(w);
                if x ~= width/2 && y ~= height/2;
                    break;
                end
            end
        end
        % Close and open screen
        Screen('CloseAll');
        screenNumber = max(Screen('Screens'));
        [width height] = Screen('WindowSize', screenNumber);
        w = Screen('OpenWindow', screenNumber,[],[],[],[]);
        block = block +1;
    end
    
    i = i + 1 ;
    
end
%% Save the behavioral data
% In the beginning, we created a file to hold all of our important data
% Now we will save all of the behavioral data in the same -.mat file

save (recordname, 'behavioral', '-append')


%% Run the working memory test
cd('../')
cd('SSTM/SSTM')

drawStop(w);
Screen('Flip',w);
WaitSecs(20);

if input == 'k';
    KbWait([], 3);
elseif input == 'm';
    GetClicks(w,0);
elseif input == 't';
    SetMouse(width/2, height/2 ,w);
    while true;
        [x,y] = GetMouse(w);
        if x ~= width/2 && y ~= height/2;
            break;
        end
    end
end

SSTM(subjID);
Screen('CloseAll');
end

