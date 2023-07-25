function [probaType,maxType,probaMaxType,pdf] = equation3Bayes(p, x)
% General Linear Model e.g. Ohms Law

e = p(1:8);
pr = p(9:16);
numberSubjects = length(x);
numberTrials = [140 35 35 140 105 105 105 140];
heur = x;

pdf = zeros(numberSubjects,1);

for i = 1:numberSubjects
     pdf(i)=(pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials(1)-heur(i,1))))+...
         (pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials(2)-heur(i,2))))+...
         (pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials(3)-heur(i,3))))+...
         (pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials(4)-heur(i,4))))+...
         (pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials(5)-heur(i,5))))+...
         (pr(6)*((1-e(6))^heur(i,6))*((e(6))^(numberTrials(6)-heur(i,6))))+...
         (pr(7)*((1-e(7))^heur(i,7))*((e(7))^(numberTrials(7)-heur(i,7))))+...
         (pr(8)*((1-e(8))^heur(i,8))*((e(8))^(numberTrials(8)-heur(i,8))));
end

probaType = zeros(numberSubjects,7);
maxType = zeros(numberSubjects,1);
probaMaxType = zeros(numberSubjects,1);

for i = 1:numberSubjects
    probaType(i,1)=(pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials(1)-heur(i,1))))/pdf(i);
    probaType(i,2)=(pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials(2)-heur(i,2))))/pdf(i);
    probaType(i,3)=(pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials(3)-heur(i,3))))/pdf(i);
    probaType(i,4)=(pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials(4)-heur(i,4))))/pdf(i);
    probaType(i,5)=0;
    probaType(i,6)=(pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials(5)-heur(i,5))))/pdf(i);
    probaType(i,7)=(pr(6)*((1-e(6))^heur(i,6))*((e(6))^(numberTrials(6)-heur(i,6))))/pdf(i);
    probaType(i,8)=(pr(7)*((1-e(7))^heur(i,7))*((e(7))^(numberTrials(7)-heur(i,7))))/pdf(i);
    probaType(i,9:12) = 0;
    probaType(i,13) = (pr(8)*((1-e(8))^heur(i,8))*((e(8))^(numberTrials(8)-heur(i,8))))/pdf(i); %column 13 of probaType = utilityMax strategy 
    
    maxType(i) = find(probaType(i,:) == max(probaType(i,:)));
    probaMaxType(i) = max(probaType(i,:));
end


end