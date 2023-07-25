function [probaType,maxType,probaMaxType,pdf] = equation2Bayes(p, x)
% General Linear Model e.g. Ohms Law

e = p(1:6);
pr = p(7:12);
numberSubjects = length(x);
numberTrials = 105;
heur = x;

pdf = zeros(numberSubjects,1);

for i = 1:numberSubjects
     pdf(i)=(pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials-heur(i,1))))+...
         (pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials-heur(i,2))))+...
         (pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials-heur(i,3))))+...
         (pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials-heur(i,4))))+...
         (pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials-heur(i,5))))+...
         (pr(6)*((1-e(6))^heur(i,6))*((e(6))^(numberTrials-heur(i,6))));
end

probaType = zeros(numberSubjects,7);
maxType = zeros(numberSubjects,1);
probaMaxType = zeros(numberSubjects,1);

for i = 1:numberSubjects
    probaType(i,1) = (pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials-heur(i,1))))/pdf(i); %column 1 of probaType = absMax strategy
    probaType(i,2:3) = 0;
    probaType(i,4) = (pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials-heur(i,4))))/pdf(i); %column 4 of probaType = absMin strategy
    probaType(i,5) = 0; %column 5 of probaType = equalization strategy
    probaType(i,6) = (pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials-heur(i,2))))/pdf(i); %column 6 of probaType = max item3 strategy
    probaType(i,7) = (pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials-heur(i,3))))/pdf(i); %column 7 of probaType = max item4 strategy
    probaType(i,8) = (pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials-heur(i,5))))/pdf(i); %column 8 of probaType = max item5 strategy
    probaType(i,9:12) =  0;
    probaType(i,13) = (pr(6)*((1-e(6))^heur(i,6))*((e(6))^(numberTrials-heur(i,6))))/pdf(i); %column 13 of probaType = utilityMax strategy
    
    maxType(i) = find(probaType(i,:) == max(probaType(i,:)));
    probaMaxType(i) = max(probaType(i,:));
end


end