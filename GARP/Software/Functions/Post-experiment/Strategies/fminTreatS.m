function [ y_output,y_max,p_output,bestP,bestQ,bestValue,bestLL,...
    utilities,mystrategyUMAX,strategyUMAXdeviation] = fminTreatS(taskS,choiceS)
%you need to feed data as two-column vector called 'x'.
%this script will call on a log-likelihood fcn called 'equation.m' that
%will report parameters as variable called 'p_fit'

x = zeros(length(choiceS),5);

for m = 1:length(taskS)
    x(m,1) = taskS(1,1,m);
    x(m,2) = taskS(1,2,m);
    x(m,3) = taskS(2,1,m);
    x(m,4) = taskS(2,2,m);
end

for m = 1:length(x)
    if choiceS(m,1) == 1
        x(m,5) = 1;
    elseif choiceS(m,1) == 2
        x(m,5) = 0;
    end
end

options = optimset('Algorithm','interior-point');
%options.MaxFunEvals = 1000;

p_output = zeros(19,2);
y_output = zeros(19,1);

j = 0;
h = 1;
while j < 1;
    p_initial = j*(ones(1,2));
    limit_lower = zeros(1,2);
    limit_upper = ones(1,2);
    [p_fit,y_val] = fmincon(@(p) equation2Item(p, x), p_initial,[],[],[],[],limit_lower,limit_upper,[],options);
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
    (bestP(2))*(x(:,2));

%calculating utility of RIGHT bundle using estimated parameters. Output
%will be in RIGHT column
utilities(:,2) = (bestP(1))*(x(:,3))+...
    (bestP(2))*(x(:,4));

for m = 1:length(utilities)
    if (utilities(m,1) > utilities(m,2))&&...
            x(m,5) == 1 %if they chose left (i.e. the higher utility bundle)
        mystrategyUMAX(m,1) = 0; %then they have no deviation
    elseif (utilities(m,1) > utilities(m,2))&&...
            x(m,5) == 0 %if they chose right bundle (i.e. the lower utility bundle)
        mystrategyUMAX(m,1) = 1; %then they have deviation
    elseif (utilities(m,1) < utilities(m,2))&&...
            x(m,5) == 0 %if they chose right bundle (i.e. the higher utility bundle)
        mystrategyUMAX(m,1) = 0; %then they have no deviation
    elseif (utilities(m,1) < utilities(m,2))&&...
            x(m,5) == 1 %if they chose left bundle (i.e. the lower utility bundle)
        mystrategyUMAX(m,1) = 1;
    end
end

strategyUMAXdeviation = nnz(mystrategyUMAX);

end



