function p=price(h,s)

global alpha;

p=h*(1-alpha)+alpha*s;