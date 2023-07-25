function [severeIndxOmitSummary,severeIndxCKBavgSummary,severeIndxCKBminSummary] = ...
        severitiesSummary(i,subjID,severeIndxOmitSummary,severeIndxCKBavgSummary,...
        severeIndxCKBminSummary,severeIndxCKBavgS,...
        severeIndxCKBminS,severeIndxS,severeIndxCKBavgC1,...
        severeIndxCKBminC1,severeIndxC1,severeIndxCKBavgC2,...
        severeIndxCKBminC2,severeIndxC2,severeIndxCKBavgC3,...
        severeIndxCKBminC3,severeIndxC3,severeIndxCKBavgCI,...
        severeIndxCKBminCI,severeIndxCI,severeIndxCKBavgAll,...
        severeIndxCKBavgC,severeIndxCKBminAll,severeIndxCKBminC)

severeIndxOmitSummary(i,1) = subjID;
severeIndxOmitSummary(i,2) = severeIndxS;
severeIndxOmitSummary(i,3) = severeIndxC1;
severeIndxOmitSummary(i,4) = severeIndxC2;
severeIndxOmitSummary(i,5) = severeIndxC3;
severeIndxOmitSummary(i,6) = severeIndxCI;

severeIndxCKBavgSummary(i,1) = subjID;
severeIndxCKBavgSummary(i,2) = severeIndxCKBavgS;
severeIndxCKBavgSummary(i,3) = severeIndxCKBavgC1;
severeIndxCKBavgSummary(i,4) = severeIndxCKBavgC2;
severeIndxCKBavgSummary(i,5) = severeIndxCKBavgC3;
severeIndxCKBavgSummary(i,6) = severeIndxCKBavgCI;
severeIndxCKBavgSummary(i,7) = severeIndxCKBavgAll;
severeIndxCKBavgSummary(i,8) = severeIndxCKBavgC;

severeIndxCKBminSummary(i,1) = subjID;
severeIndxCKBminSummary(i,2) = severeIndxCKBminS;
severeIndxCKBminSummary(i,3) = severeIndxCKBminC1;
severeIndxCKBminSummary(i,4) = severeIndxCKBminC2;
severeIndxCKBminSummary(i,5) = severeIndxCKBminC3;
severeIndxCKBminSummary(i,6) = severeIndxCKBminCI;
severeIndxCKBminSummary(i,7) = severeIndxCKBminAll;
severeIndxCKBminSummary(i,8) = severeIndxCKBminC;

end

