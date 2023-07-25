function [] = drawBreak( w )

% Writs "Stop" in the center of the off-screen window

if exist('w','var') == 0;
    screenNumber = max(Screen('Screens'));
    w = Screen(screenNumber, 'OpenWindow',[],[],[],[]);
end

Screen(w,'TextSize',150)
DrawFormattedText(w, 'Stop', 'center', 'center', [0 0 0]);

end

