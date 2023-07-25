function y = equation1(p, x)
% General Linear Model e.g. Ohms Law

e = p(1:5);
pr = p(6:10);
numberSubjects = length(x);
numberTrials = 35;
heur = x;

for i = 1:numberSubjects
     pdf(i)=(-1)*(log((pr(1)*((1-e(1))^heur(i,1))*((e(1))^(numberTrials-heur(i,1))))+...
         (pr(2)*((1-e(2))^heur(i,2))*((e(2))^(numberTrials-heur(i,2))))+...
         (pr(3)*((1-e(3))^heur(i,3))*((e(3))^(numberTrials-heur(i,3))))+...
         (pr(4)*((1-e(4))^heur(i,4))*((e(4))^(numberTrials-heur(i,4))))+...
         (pr(5)*((1-e(5))^heur(i,5))*((e(5))^(numberTrials-heur(i,5))))));

end

y = sum(pdf(1:numberSubjects));

end