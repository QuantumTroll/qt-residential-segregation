function [mi mj mk]=bestAvailable(Ci)

global Nn;
global Nh;

global C;
global h;
global s;
global p;

global alpha;
global beta;
global lambda;

global isAvailable;

max=-1;
mi=-1;
mj=-1;
mk=-1;

for i=1:Nn
    for j=1:Nn
        for k=1:Nh
            % if home is available and affordable
            % neighborhood status is more important than home quality
%             if(isAvailable(i,j,k)==1 && Ci > p(i,j,k) && s(i,j)>max)
%                 max=s(i,j);
%                 mi=i;
%                 mj=j;
%                 mk=k;
%             end
            % fanciest house available is preferred
%             if(isAvailable(i,j,k)==1 && Ci > p(i,j,k) && h(i,j,k)>max)
%                  max=h(i,j,k);
%                  mi=i;
%                  mj=j;
%                  mk=k;
%             end
            % most expensive home is preferred
%             if(isAvailable(i,j,k)==1 && Ci > p(i,j,k) && p(i,j,k)>max)
%                  max=p(i,j,k);
%                  mi=i;
%                  mj=j;
%                  mk=k;
%             end 
            % "smart" choice based on future price of home
            if(isAvailable(i,j,k)==1 && Ci > p(i,j,k))
                f = (1-alpha)*(C(i,j,k)-p(i,j,k))/(1+C(i,j,k)-p(i,j,k)) + alpha*s(i,j);
                if(f>max)
                    max=f;
                    mi=i;
                    mj=j;
                    mk=k;
                end
            end
                
        end        
    end
end