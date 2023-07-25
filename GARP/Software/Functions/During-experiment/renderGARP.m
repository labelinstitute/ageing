function [] = renderGARP( item1, item2, item3, item4, amountOfItem1, amountOfItem2, amountOfItem3, amountOfItem4, w )
% Creates and organizes the image textures that will be displayed on subject's screen

screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);

% Open color files
black = imread('black.jpg'); 
grey = imread('grey.jpg'); 

%% Make image textures
% Once image files have been opened, they need to made into a texture. Here
% is the description of Screen('MakeTexture',[],[]): Convert the 2D or 3D
% matrix 'imageMatrix' into an OpenGL texture and return an index which may
% be passed to 'DrawTexture' to specify the texture.

item1t = Screen('MakeTexture',w,item1);
item2t = Screen('MakeTexture',w,item2);
item3t = Screen('MakeTexture',w,item3);
item4t = Screen('MakeTexture',w,item4);
blackt = Screen('MakeTexture',w,black);
greyt = Screen('MakeTexture',w,grey);

%% Set position constants

centerw = width/2;                % Center width of the screen
centerh = height/2;               % Center height of the screen
eccen =   150;                    % Eccentricity. Distance from the center to the right edge of the array
itemw =   70;                     % Width of one item in array
itemh =   1.5*itemw;              % Height of one item in array
gutterw = 20;                     % Width of gutters between items
gutterh = 20;                     % Height of gutters between items

devLineHeight = height*.9;        % The height of the black box in the middle of the screen
devLineWidth  = 1;                % The width of the black box in the middle of the screen

% Everything below here is coded in terms of the numbers above. 'p' means
% position, 'w' means width (it is an x-coordinate), 'h' means height (it
% is a y-coordinate), 'l' means left (coordinate for a left side box), 'r'
% means right (coordinate for a right side box)

pwl1 = centerw - eccen;
pwl2 = pwl1 - itemw;
pwl3 = pwl2 - gutterw;
pwl4 = pwl3 - itemw;
pwl5 = pwl4 - gutterw;
pwl6 = pwl5 - itemw;
pwl7 = pwl6 - gutterw;
pwl8 = pwl7 - itemw;

pwr1 = centerw + eccen;
pwr2 = pwr1 + itemw;
pwr3 = pwr2 + gutterw;
pwr4 = pwr3 + itemw;
pwr5 = pwr4 + gutterw;
pwr6 = pwr5 + itemw;
pwr7 = pwr6 + gutterw;
pwr8 = pwr7 + itemw;

ph1 = centerh - (gutterh + 1.5*itemh);
ph2 = ph1 + itemh;
ph3 = ph2 + gutterh;
ph4 = ph3 + itemh;
ph5 = ph4 + gutterh;
ph6 = ph5 + itemh;

% These are here so that the cat()'s will have something to grab on to

draw = [];
leftPositions = [];
topPositions = [];
rightPositions = [];
bottomPositions = [];

% The line that divides the the screen in half

draw = cat(1,draw,blackt);
leftPositions = cat(2,leftPositions,    centerw - devLineWidth);
topPositions = cat(2,topPositions,      centerh - devLineHeight/2);
rightPositions = cat(2,rightPositions,  centerw + devLineWidth);
bottomPositions = cat(2,bottomPositions,centerh + devLineHeight/2);

% Item display locations or 'boxes'
% Left side of scren
% Box 1L
if amountOfItem1 >= 1;  
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 2L
if amountOfItem1 >= 2;
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 3L
if amountOfItem1 >= 3;
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 4L
if amountOfItem1 >= 4;
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 5L
if amountOfItem1 >= 5;
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 6L
if amountOfItem1 >= 6;
    draw = cat(1,draw,item1t);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 7L
if amountOfItem2 >= 1;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 8L
if amountOfItem2 >= 2;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 9L
if amountOfItem2 >= 3;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 10L
if amountOfItem2 >= 4;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 11L
if amountOfItem2 >= 5;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 12L
if amountOfItem2 >= 6;
    draw = cat(1,draw,item2t);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph6);
end

% Right side of screen
% Box 1R
if amountOfItem3 >= 1;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 2R
if amountOfItem3 >= 2;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 3R
if amountOfItem3 >= 3;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 4R
if amountOfItem3 >= 4;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 5R
if amountOfItem3 >= 5;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 6R
if amountOfItem3 >= 6;
    draw = cat(1,draw,item3t);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 7R
if amountOfItem4 >= 1;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 8R
if amountOfItem4 >= 2;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 9R
if amountOfItem4 >= 3;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 10R
if amountOfItem4 >= 4;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 11R
if amountOfItem4 >= 5;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 12R
if amountOfItem4 >= 6;
    draw = cat(1,draw,item4t);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph6);
end

% Grey display locations or 'boxes'
% Left side of screen
% Box 1L
if amountOfItem1 < 1;  
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 2L
if amountOfItem1 < 2;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 3L
if amountOfItem1 < 3;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 4L
if amountOfItem1 < 4;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 5L
if amountOfItem1 < 5;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl6);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl5);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 6L
if amountOfItem1 < 6;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl8);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl7);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 7L
if amountOfItem2 < 1;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 8L
if amountOfItem2 < 2;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 9L
if amountOfItem2 < 3;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 10L
if amountOfItem2 < 4;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 11L
if amountOfItem2 < 5;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl4);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl3);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 12L
if amountOfItem2 < 6;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwl2);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwl1);
    bottomPositions = cat(2,bottomPositions, ph6);
end

% Right side of screen
% Box 1R
if amountOfItem3 < 1;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 2R
if amountOfItem3 < 2;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 3R
if amountOfItem3 < 3;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 4R
if amountOfItem3 < 4;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 5R
if amountOfItem3 < 5;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr3);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr4);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 6R
if amountOfItem3 < 6;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr1);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr2);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 7R
if amountOfItem4 < 1;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 8R
if amountOfItem4 < 2;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph3);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph4);
end
% Box 9R
if amountOfItem4 < 3;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 10R
if amountOfItem4 < 4;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph1);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph2);
end
% Box 11R
if amountOfItem4 < 5;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr5);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr6);
    bottomPositions = cat(2,bottomPositions, ph6);
end
% Box 12R
if amountOfItem4 < 6;
    draw = cat(1,draw,greyt);
    leftPositions = cat(2,leftPositions,    pwr7);
    topPositions = cat(2,topPositions,       ph5);
    rightPositions = cat(2,rightPositions,  pwr8);
    bottomPositions = cat(2,bottomPositions, ph6);
end

v = cat(1,leftPositions,topPositions,rightPositions,bottomPositions); % concatenate all that has been drawn, including their corresponding x- and y- coordinates

Screen('DrawTextures',w,draw,[],v) % draw 'v' or all of the images for that trial


end

