function disp3d(C)

global Nn;
global Nh;

maxC = max(max(max(C)))
minC = min(min(min(C)))
dC = maxC-minC;
meanC = mean(mean(mean(C)))

low = meanC-dC/3
high = meanC+dC/3

hold off
plot(0,0,'*')
hold on

bx=sqrt(Nh);

for i=1:Nn
    for j=1:Nn
        for k=1:Nh
            x=i+mod(k,bx)/bx;
            y=j+(k-mod(k,bx))/Nh;
            if(C(i,j,k)<low)
                plot(x,y,'r.');
            elseif(C(i,j,k)<high)
                plot(x,y,'k.');
            else
                plot(x,y,'b.');
            end
        end
    end
end

hold off