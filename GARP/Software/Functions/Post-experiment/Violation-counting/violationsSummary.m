function [violationSummary] = violationsSummary(i,subjID,violationSummary,...
        violationA,violationCountS,violationCountC1,violationCountC2,...
        violationCountC3,violationCountCI)
    
    violationSummary(i,1) = subjID;
    violationSummary(i,2) = violationA;
    violationSummary(i,3) = violationCountS;
    violationSummary(i,4) = violationCountC1;
    violationSummary(i,5) = violationCountC2;
    violationSummary(i,6) = violationCountC3;
    violationSummary(i,7) = violationCountCI;
    x = [violationCountC1,violationCountC2,violationCountC3,violationCountCI];
    totalTreatC = sum(x,2);
    violationSummary(i,8) = totalTreatC;

end

