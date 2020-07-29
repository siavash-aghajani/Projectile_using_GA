function newchild=Mutation(child,xmin,xmax,nvar,fr,L,l,h,g,r,mass)
newchromosome.x=rand(1,nvar).*(xmax-xmin)+xmin;
newchild=child;
i=randi(nvar);
newchild.x(i)=newchromosome.x(i);
newchild.cost=Cost(newchild.x(1),newchild.x(2),fr,L,l,h,g,r,mass);