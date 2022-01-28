function y = renyi_entro(DATA,alpha)
    y = (1/(1-alpha)*log2(sum(sum((abs(DATA)).^alpha))));
end