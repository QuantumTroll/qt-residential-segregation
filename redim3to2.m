function td=redim3to2(C)
global Nn;
global Nh;

bx=sqrt(Nh);

td=zeros(Nn*bx);

for i=1:Nn
    for j=1:Nn
        for k=1:bx
            for l=1:bx                
                td((i-1)*bx+k,(j-1)*bx+l)=C(i,j,(k-1)*bx+l);
            end
        end
    end
end