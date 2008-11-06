
global Nn;
global Nh;
global C;
global p;
global h;
global s;
global isAvailable;
global alpha;

global lambda;
global beta;

lambda=0.01 % rate of home quality decay
beta=1.2    % home improvement factor

Nn = 10     % Nn x Nn neighborhoods on grid
Nh = 100    % # households in nbhd

alpha = 0.01 % socioeconomic quality bias in housing price

iempty = 0.1   % initial proportion of empty lots

Np = Nn*Nn*Nh;   % # households total

% Income distribution params:
Cinitmean = 100;
Cinitsd = 50;

'initializing'

% Wealth of household
C = zeros(Nn,Nn,Nh);
% Quality of house
h = zeros(Nn,Nn,Nh);
% Price
p = zeros(Nn,Nn,Nh);
% Social status of neighbourhood
s = zeros(Nn,Nn);
% Is available?
isAvailable = zeros(Nn,Nn,Nh);
%Price paid
pp=zeros(Nn,Nn,Nh);

%For each neighbourhood
for i=1:Nn
    for j=1:Nn
        %For each house in nbhd.
        for k=1:Nh
            if (rand > iempty)
                % income status of household: Normal dist
                C(i,j,k)=Cinitsd*randn+Cinitmean;
                % initial quality of housing
                h(i,j,k) = C(i,j,k) + 10*randn-10; 
                isAvailable(i,j,k)=0;
            else
                h(i,j,k) = Cinitsd*randn+Cinitmean+ 10*randn; 
                isAvailable(i,j,k)=1;
            end
        end
        
        % socioeconomic quality of nbhd               
        s(i,j)=sum(C(i,j,:))/(Nh-sum(isAvailable(i,j,:)));  
        % price of housing
        p(i,j,1:Nh) = (1-alpha)*h(i,j,1:Nh) + alpha*s(i,j);       
    end
end
pp=p;

Y = 30      % length of experiment
R = 0.0     % natural turnover rate
tspy = 500   % time-steps per year. How many people move in a year, anyway?

avgS=zeros(1,Y);
popcount=zeros(1,Y);

'running...'

for year = 1:Y
    H2=redim3to2(h);
    C2=redim3to2(C);
    avgS(year)=mean(mean(s));
    avgH(year)=mean(mean(H2));
    avgP(year)=mean(mean(mean(p)));
    popcount(year)=Np-sum(sum(sum(isAvailable)));
    imagesc(C2,[0 250]);colorbar;
    %imagesc(s,[0 150]);colorbar;
    drawnow
   % M(year)=getframe
  %  drawnow
    for t = 1:tspy
        % pick random household
        ti = ceil(rand*Nn);
        tj = ceil(rand*Nn);  
        tk = ceil(rand*Nh);
        if(isAvailable(ti,tj,tk)==1)
            % move an outsider into town
        %    isAvailable(ti,tj,tk)=0;
            
            % income is a little above homeprice
        %    C(i,j,k)=p(ti,tj,tk)*(1+randn*.1);
        %    s(ti,tj)=sum(C(ti,tj,:))/(Nh-sum(isAvailable(ti,tj,:))); 
        %    p(ti,tj,1:Nh) = price(h(ti,tj,1:Nh),s(ti,tj));
            continue
        end        
        
        [mi,mj,mk] = bestAvailable(C(ti,tj,tk));
        % decide whether to move out of town
        if(mi < 1 || rand < R)
            % move out of town
            %isAvailable(ti,tj,tk)=1;
            %C(ti,tj,tk)=0;
            %s(ti,tj)=sum(C(ti,tj,:))/(Nh-sum(isAvailable(ti,tj,:))); 
            %p(ti,tj,1:Nh) = price(h(ti,tj,1:Nh),s(ti,tj));
            continue
        end
        
        % move to another neighborhood
        isAvailable(ti,tj,tk)=1;
        isAvailable(mi,mj,mk)=0;
        C(mi,mj,mk)=C(ti,tj,tk);
        C(ti,tj,tk)=0;
        pp(mi,mj,mk) = p(mi,mj,mk);
        
        s(mi,mj)=sum(C(mi,mj,:))/(Nh-sum(isAvailable(mi,mj,:)));  
        s(ti,tj)=sum(C(ti,tj,:))/(Nh-sum(isAvailable(ti,tj,:)));  
        
        p(mi,mj,1:Nh) = price(h(mi,mj,1:Nh),s(mi,mj));
        p(ti,tj,1:Nh) = price(h(ti,tj,1:Nh),s(ti,tj));
        
    end
    % update housing quality for each household
    for i=1:Nn
        for j=1:Nn
            for k=1:Nh
                h(i,j,k)=updateH(C(i,j,k), h(i,j,k), s(i,j), pp(i,j,k));
            end
        end
    end
end
    


