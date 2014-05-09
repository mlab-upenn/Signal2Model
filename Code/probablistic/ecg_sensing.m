function ecg_data=ecg_sensing(node_pos,path_table)

ecg_list=[1,4];
ecg_data=0;

act_path=find(cell2mat(path_table(:,2))~=1);

for i=1:length(act_path)
    p1=node_pos(path_table{act_path(i),3},:);
        p2=node_pos(path_table{act_path(i),4},:);
%         path_length=path_table{act_local(j),12};
%         path_slope=path_table{act_local(j),13};
        
        
        switch path_table{act_path(i),2}
            case 2 % Ante
                cur_timer=path_table{act_path(i),5};
                def_timer=path_table{act_path(i),6};
                
                wave_front=[p1(1)+(p2(1)-p1(1))*(def_timer-cur_timer)/def_timer,...
                            p2(2)+(p1(2)-p2(2))*cur_timer/def_timer];
            case 3 % Retro
                cur_timer=path_table{act_path(i),7};
                def_timer=path_table{act_path(i),8};
                wave_front=[p1(1)+(p2(1)-p1(1))*cur_timer/def_timer,...
                            p2(2)+(p1(2)-p2(2))*(def_timer-cur_timer)/def_timer];
            
            otherwise
                wave_front=[Inf,Inf];
                
                
        end
              if ~isempty(find(ecg_list==act_path(i))) && wave_front(1,1)~=Inf
                    d=abs(sqrt(3)/3*wave_front(1,1)-wave_front(1,2)+217.269)/sqrt(4/3); 
                    ecg_data=ecg_data+d/156.87*5;
              end
    
    
end