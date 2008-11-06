function home=bestAvailable(Ci)

global Nn;
global Nh;

global C;
global h;
global s;
global p;

global isAvailable;



for i=1:Nn
    for j=1:Nn
        for k=1:Nh
            % if home is available and affordable
            if(isAvailable(i,j,k)==1 && Ci > p(i,j,k))
                
            end
        end
    end
end