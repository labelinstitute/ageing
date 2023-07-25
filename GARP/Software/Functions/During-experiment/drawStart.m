function [] = drawStart(w)

% Writes "Wait for Instructions. Do not touch anything." in the center of
% the off-screen window

screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);


if exist('w','var') == 0;
    w = Screen(screenNumber, 'OpenWindow',[],[],[],[]);
end

Screen(w,'TextSize',50)
DrawFormattedText(w, 'Wait for Instructions.\n\nDo not touch anything.', 'center', 'center', [0 0 0]);

end

