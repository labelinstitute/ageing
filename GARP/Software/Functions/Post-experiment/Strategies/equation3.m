function y = equation3(p, x)
% General Linear Model e.g. Ohms Law

e = p(1:8);
pr = p(9:16);
numberSubjects = length(x);
numberTrials = [140 35 35 140 105 105 105 140];
heur = x;

for i = 1:numberSubjects
     pdf(i)=(-1)*(log((pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials(1)-heur(i,1))))+...
         (pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials(2)-heur(i,2))))+...
         (pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials(3)-heur(i,3))))+...
         (pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials(4)-heur(i,4))))+...
         (pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials(5)-heur(i,5))))+...
         (pr(6)*((1-e(6))^heur(i,6))*((e(6))^(numberTrials(6)-heur(i,6))))+...
         (pr(7)*((1-e(7))^heur(i,7))*((e(7))^(numberTrials(7)-heur(i,7))))+...
         (pr(8)*((1-e(8))^heur(i,8))*((e(8))^(numberTrials(8)-heur(i,8))))));
end

y = sum(pdf(1:numberSubjects));

end