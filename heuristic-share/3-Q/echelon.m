function [E,b,lead,I]=echelon(A,bin)
% Reduces A of the linear equation Ax=bin into row reduced echelon form.
% The new (equivalent) system is given by Ex=b.
% I is the cumulative row operations applied, thus if A is invertible I will be the
% inverse of A. lead is an index vector containing the column numbers of
% the  leading nonzero terms for each row.
% Erhan Oztop May 12, 2005
 
     [M,N]=size(A);
     
    E=A;
    E;
     I=diag(ones(min(M,N),1));   
     if (isempty(bin))
     bin=1:M;
     end;
     
     b=bin;
    elc=0;
    topleft=1;
    
    lead=[];
    for col=1:N,   
        %fprintf('Eliminating column %d\n',col);
        piv=E(topleft,col);
        if (piv==0) ,
            %disp('piv got zero, altering rows');
          for i=topleft:M,
              inewp=-1;
           if E(i,col)~=0,
               inewp=i;
               temp=E(topleft,:);
               E(topleft,:)=E(inewp,:);
               E(inewp,:)=temp;
               temp=I(topleft,:);
               I(topleft,:)=I(inewp,:);
               I(inewp,:)=temp;
               piv=E(topleft,col);
               btemp=b(topleft);
               b(topleft)=b(inewp);
               b(inewp)=btemp;
               break;
           end; %if
        end; % for ...:M
        
            if inewp==-1,
                   %fprintf('Ooops should not happen, right?') ;
           end;     
     end;  % if piv==0
     if (piv==0),
       % fprintf('Ooops piv=0') ;
       continue;
     end;
lead=[lead,col];
 E(topleft,col:N)=E(topleft,col:N)/piv;
 I(topleft,:)=I(topleft,:)/piv;
 piv=1;
     for i=1:M,    
         if (i==topleft),
             continue;
         end;
        c=-E(i,col)/piv;   
        %fprintf('i:%d c:%f\n',i,c);
      
        E(i,col:N)=E(i,col:N)+E(topleft,col:N)*c;
        I(i,:)=I(i,:)+I(topleft,:)*c;
    end;
    elc=elc+1; 
    topleft=topleft+1;     
    if elc==M,
    return;    
    end;
end; %for topleft=1:N,   
	    
         



