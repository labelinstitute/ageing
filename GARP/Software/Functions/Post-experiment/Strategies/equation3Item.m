function y = equation3Item(p, x)

beta1 = p(1); %for the 3rd item
beta2 = p(2); %for the 4th item
beta3 = p(3); %for the 5th item

numberObs = length(x);
q1L = x(:,1);
q2L = x(:,2);
q3L = x(:,3);
q1R = x(:,4);
q2R = x(:,5);
q3R = x(:,6);

probFcn = zeros(numberObs,1);

for n = 1:numberObs
probFcn(n) = (-1)*(x(n,7)*(log(1/(1 + exp(-beta1*(q1L(n)-q1R(n)) -beta2*(q2L(n)-q2R(n)) -beta3*(q3L(n)-q3R(n)))))) + ...
        (1-x(n,7))*(log(1 - (1/(1 + exp(-beta1*(q1L(n)-q1R(n)) -beta2*(q2L(n)-q2R(n)) - beta3*(q3L(n)-q3R(n))))))));
end

y = sum(probFcn(1:numberObs));

end