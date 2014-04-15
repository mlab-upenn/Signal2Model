function sing_const=constraint(condition,S1)
sing_const=[];

switch condition
    case 'R1'
        sing_const=[sing_const;{'ERP_SA_max+RRP_SA','>',S1}];
        sing_const=[sing_const;{'ERP_SA_max','<',S1}];
    case 'R2'
        sing_const=[sing_const;{'ERP_SA_max+RRP_SA','<',S1}];
    case 'R3'
        sing_const=[sing_const;{'ERP_SA_cur+RRP_SA','<',S1}];
    case 'R4'
        sing_const=[sing_const;{'ERP_F1_cur','>',S1}];
        sing_const=[sing_const;{'ERP_S1_cur','<',S1}];
    case 'R5'
        sing_const=[sing_const;{'ERP_F1_cur+RRP_F1','>',S1}];
        sing_const=[sing_const;{'ERP_F1_cur','<',S1}];
    case 'R6'
        sing_const=[sing_const;{'ERP_F1_cur+RRP_F1','<',S1}];
    case 'R7'
         sing_const=[sing_const;{'ERP_F1_cur','<',S1}];
    case 'T1'
         sing_const=[sing_const;{'ERP_SA_max','>',S1}];
    case 'T2'
         sing_const=[sing_const;{'ERP_F1_max','>',S1}];
         sing_const=[sing_const;{'ERP_S1_max','>',S1}];
    case 'T3'
        sing_const=[sing_const;{'ERP_F1_max','<',S1}];
end