function sing_const=const_gen(condition,S1)
sing_const=[];

switch condition
    case 'R1'
%         sing_const=[sing_const;{'ERP_SA_max+RRP_SA','>',S1}];
%         sing_const=[sing_const;{'ERP_SA_max','<',S1}];
        new_const=zeros(1,25);
        new_const(2)=-1;
        new_const(3)=-1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
        new_const=zeros(1,25);
        new_const(2)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R2'
%         sing_const=[sing_const;{'ERP_SA_max+RRP_SA','<',S1}];
        new_const=zeros(1,25);
        new_const(2)=1;
        new_const(3)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
                new_const=zeros(1,25);
        new_const(2)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R3'
        %sing_const=[sing_const;{'ERP_SA_cur+RRP_SA','<',S1}];
        new_const=zeros(1,25);
        new_const(1)=1;
        new_const(3)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
                new_const=zeros(1,25);
        new_const(1)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R4'
%         sing_const=[sing_const;{'ERP_F1_cur','>',S1}];
%         sing_const=[sing_const;{'ERP_S1_cur','<',S1}];
        new_const=zeros(1,25);
        new_const(7)=-1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
        new_const=zeros(1,25);
        new_const(13)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R5'
%         sing_const=[sing_const;{'ERP_F1_cur+RRP_F1','>',S1}];
%         sing_const=[sing_const;{'ERP_F1_cur','<',S1}];
        new_const=zeros(1,25);
        new_const(7)=-1;
        new_const(9)=-1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
        new_const=zeros(1,25);
        new_const(7)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R6'
        %sing_const=[sing_const;{'ERP_F1_cur+RRP_F1','<',S1}];
        new_const=zeros(1,25);
        new_const(7)=1;
        new_const(9)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const]; 
        new_const=zeros(1,25);
        new_const(7)=1;
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'R7'
        % sing_const=[sing_const;{'ERP_F1_cur','<',S1}];
        new_const=zeros(1,25);
        new_const(7)=1;
        
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'T1'
         %sing_const=[sing_const;{'ERP_SA_max','>',S1}];
        new_const=zeros(1,25);
        new_const(2)=-1;
        
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'T2'
%          sing_const=[sing_const;{'ERP_F1_max','>',S1}];
%          sing_const=[sing_const;{'ERP_S1_max','>',S1}];
        new_const=zeros(1,25);
        new_const(8)=-1;
       
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
                new_const=zeros(1,25);
        new_const(14)=-1;
      
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
    case 'T3'
%         sing_const=[sing_const;{'ERP_F1_max','<',S1}];
        new_const=zeros(1,25);
        new_const(7)=1;
        
        new_const(25)=S1;
        sing_const=[sing_const;new_const];
end