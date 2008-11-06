function h = updateH(c, h, s,pp)

global lambda;
global beta;

q=0;

if(c > pp)
    q=beta*((c-pp)/(1+c-pp));
end

dhdt = q - lambda*h;

h = h + dhdt;


if(h<0)
    h=0;
end
