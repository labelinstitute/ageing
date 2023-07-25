function [] = drawFixation(window)

% Simple -- It draws a fixation cross on the off-screen window then
% displays wit with the 'Flip' command

screenNumber = max(Screen('Screens'));

[width height] = Screen('WindowSize', screenNumber);
rect = [0,0,width,height];
[X,Y] = RectCenter(rect);
FixCross = [X-1,Y-40,X+1,Y+40;X-40,Y-1,X+40,Y+1];
Screen('FillRect', window, [0,0,0], FixCross');
Screen('Flip', window);

end

