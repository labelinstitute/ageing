function [ y_output,y_max,p_output,bestP,bestQ,bestValue,bestLL,...
    utilities,mystrategyUMAX,strategyUMAXdeviation] = ...
    fminTreatC(taskC1,taskC2,taskC3,choiceC1,choiceC2,choiceC3)
%you need to feed data as two-column vector called 'x'.
%this script will call on a log-likelihood fcn called 'equation.m' that
%will report parameters as variable called 'p_fit'

x = zeros(length(taskC1),7);

for m = 1:length(taskC1)
    x1(m,1) = taskC1(1,1,m);
    x1(m,2) = taskC1(1,2,m);
    x1(m,3) = taskC1(1,3,m);
    x1(m,4) = taskC1(2,1,m);
    x1(m,5) = taskC1(2,2,m);
    x1(m,6) = taskC1(2,3,m);
    x1(m,7) = choiceC1(m,1);
end

for m = 1:length(taskC2)
    x2(m,1) = taskC2(1,1,m);
    x2(m,2) = taskC2(1,2,m);
    x2(m,3) = taskC2(1,3,m);
    x2(m,4) = taskC2(2,1,m);
    x2(m,5) = taskC2(2,2,m);
    x2(m,6) = taskC2(2,3,m);
    x2(m,7) = choiceC2(m,1);
end

for m = 1:length(taskC3);
    x3(m,1) = taskC3(1,1,m);
    x3(m,2) = taskC3(1,2,m);
    x3(m,3) = taskC3(1,3,m);
    x3(m,4) = taskC3(2,1,m);
    x3(m,5) = taskC3(2,2,m);
    x3(m,6) = taskC3(2,3,m);
    x3(m,7) = choiceC3(m,1);
end

x = cat(1,x1,x2,x3);

for m = 1:length(x)
    if x(m,7) == 1
        x(m,7) = 1;
    elseif x(m,7) == 2
        x(m,7) = 0;
    end
end

options = optimset('Algorithm','interior-point');
%options.MaxFunEvals = 1000;

p_output = zeros(19,3);
y_output = zeros(19,1);

j = 0;
h = 1;
while j < 1;
    p_initial = j*(ones(1,3));
    limit_lower = zeros(1,3);
    limit_upper = ones(1,3);
    [p_fit,y_val] = fmincon(@(p) equation3Item(p, x), p_initial,[],[],[],[],limit_lower,limit_upper,[],options);
    p_output(h,:) = p_fit;
    y_output(h,1) = y_val;
    j = j + 0.05;
    h = h + 1;
end

y_max = min(y_output);
b = find(y_output == min(y_output));
c = min(b);
bestP = p_output(c,:);
bestLL = y_max;
for j = 1:length(bestP)
    bestQ(j) = bestP(j)/bestP(1);
    bestValue(j) = exp(bestQ(j));
end

%calculating utility of LEFT bundle using estimated parameters. Output will
%be in LEFT column
utilities(:,1) = (bestP(1))*(x(:,1))+...
    (bestP(2))*(x(:,2)) + (bestP(3))*(x(:,3));

%calculating utility of RIGHT bundle using estimated parameters. Output
%will be in RIGHT column
utilities(:,2) = (bestP(1))*(x(:,4))+...
    (bestP(2))*(x(:,5)) + (bestP(3))*(x(:,6));

for m = 1:length(utilities)
    if (utilities(m,1) > utilities(m,2))&&...
            x(m,7) == 1 %if they chose left (i.e. the higher utility bundle)
        mystrategyUMAX(m,1) = 0; %then they have no deviation
    elseif (utilities(m,1) > utilities(m,2))&&...
            x(m,7) == 0 %if they chose right bundle (i.e. the lower utility bundle)
        mystrategyUMAX(m,1) = 1; %then they have deviation
    elseif (utilities(m,1) < utilities(m,2))&&...
            x(m,7) == 0 %if they chose right bundle (i.e. the higher utility bundle)
        mystrategyUMAX(m,1) = 0; %then they have no deviation
    elseif (utilities(m,1) < utilities(m,2))&&...
            x(m,7) == 1 %if they chose left bundle (i.e. the lower utility bundle)
        mystrategyUMAX(m,1) = 1;
    end
end

strategyUMAXdeviation = nnz(mystrategyUMAX);

end



