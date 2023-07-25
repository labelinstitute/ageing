function y = equation2Item(p, x)

beta1 = p(1);
beta2 = p(2);

numberObs = length(x);
q1L = x(:,1);
q2L = x(:,2);
q1R = x(:,3);
q2R = x(:,4);

probFcn = zeros(numberObs,1);

for n = 1:numberObs
probFcn(n) = (-1)*(x(n,5)*(log(1/(1 + exp(-beta1*(q1L(n)-q1R(n)) -beta2*(q2L(n)-q2R(n)))))) + ...
        (1-x(n,5))*(log(1 - (1/(1 + exp(-beta1*(q1L(n)-q1R(n)) -beta2*(q2L(n)-q2R(n))))))));
end

y = sum(probFcn(1:numberObs));

end