function disp2d(S)
global Nn;
global Nh;

maxS = max(max(S))
minS = min(min(S))
dS = maxS-minS;
meanS = mean(mean(S))

low = meanS-dS/4
high = meanS+dS/4

hold off
plot(0,0,'*')
hold on

for i=1:Nn
    for j=1:Nn
        if(S(i,j)<low)
            plot(i,j,'r.');
        elseif(S(i,j)<high)
            plot(i,j,'k.');
        else
            plot(i,j,'b.');
        end
    end
end

hold off