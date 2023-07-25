function [MLEoutput] = MLE(j,treatS,treatC,bothTreats)

%you need to feed data as two-column vector called 'x'.
%this script will call on a log-likelihood fcn called 'equation.m' that
%will report parameters as variable called 'p_fit'

if j == 1
    x = treatS;
    number = 2*(size(treatS,2)); %twice the number of columns (heuristics)=10
elseif j == 2
    x = treatC;
    number = 2*(size(treatC,2)); %twice the number of columns (heuristics)=12
elseif j == 3
    x = bothTreats;
    number = 2*(size(bothTreats,2)); %twice the number of columns (heuristics)=16
end

p_output = zeros(19,number);
parameter = 0;
i = 1;
y_output = zeros(19,1);

while parameter < 1 && i < 20
    p_initial = parameter*ones(1,number);
    
    lowerBound = zeros(1,number);
    upperBound = ones(1,number);
    sumProbabilitiesMatrix = cat(2,lowerBound(1:number/2),upperBound(1:number/2));
    sumProbabilities = 1;
    options = optimset('Algorithm','interior-point');
    
    if j == 1
        [p_fit, y_val] = fmincon(@(p) equation1(p, x),p_initial,[],[],sumProbabilitiesMatrix,sumProbabilities,lowerBound,upperBound,[],options);
    elseif j == 2
        [p_fit, y_val] = fmincon(@(p) equation2(p, x),p_initial,[],[],sumProbabilitiesMatrix,sumProbabilities,lowerBound,upperBound,[],options);
    elseif j == 3
        [p_fit, y_val] = fmincon(@(p) equation3(p, x),p_initial,[],[],sumProbabilitiesMatrix,sumProbabilities,lowerBound,upperBound,[],options);
    end
    p_output(i,1:number) = p_fit;
    y_output(i,1) = y_val;
    
    parameter = parameter + 0.05;
    i = i + 1;
end

b = find(y_output == min(y_output));
c = min(b);
MLEoutput.pOutput = p_output;
MLEoutput.yOutput = y_output;
MLEoutput.bestP = p_output(c,:);
MLEoutput.bestSumPDF = min(y_output);

%go back into the similar functions (as equation1, equation2, equation 3) but
%this time, feed in the estimates from the ML estimation and using Bayes'
%Rule, deduce the probability that each subject is following each heuristic
%in twoItemGARP (j == 1), in threeItemGArP (j==2), and in all trials of
%GARP (j ==3)
if j == 1
    [probaType,maxType,probaMaxType,pdf] = equation1Bayes(MLEoutput.bestP,x);
elseif j == 2
    [probaType,maxType,probaMaxType,pdf] = equation2Bayes(MLEoutput.bestP,x);
elseif j == 3
    [probaType,maxType,probaMaxType,pdf] = equation3Bayes(MLEoutput.bestP,x);
end

MLEoutput.probaType = probaType;
MLEoutput.maxType = maxType;
MLEoutput.probaMaxType = probaMaxType;
MLEoutput.bestPDF = pdf;

end





