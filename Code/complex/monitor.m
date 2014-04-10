function [pace,condition]=monitor(S1,A1,A2,A6,A7)
global m_state
global Tpace
global t
global lastSA
global lastAH
global lastHV
global Intrinsic
global slowpath
global AVNRT
global terminated
global pace_round
condition=0;
pace=0;
switch m_state
    case 'waitI1'
        if A1
            m_state='waitI2';
            Tpace=0;
            t=0;
            
        end
            return
        
    case 'waitI2'
        if A2
            m_state='waitI6';
            lastSA=t;
            t=0;
        end
            return
    case 'waitI6'
        if A6
            m_state='waitI7';
            lastAH=t;
            t=0;
        end
        return
    case 'waitI7'
        if A7
            Intrinsic=Intrinsic+1;
            if Intrinsic>=4
                m_state='InitPace';
            else
                m_state='waitI1';
                lastHV=t;
                t=0;
            end
        end
        return
    case 'InitPace'
        if A2 && slowpath==1
            AVNRT=1;
            m_state='AVNRT2';
        else if Tpace>=S1
                m_state='wait2';
                pace=1;
                pace_round=pace_round+1;
                Tpace=0;
                t=0;
            end
        end
        return
    case 'wait2'
        if Tpace>=S1
            condition=1;
            pace=1;
            terminated=1;
            return
        end
        if A2
            m_state='wait6';
            if abs(t-lastSA)>=2
                condition=2;
            end
        end
        return
    case 'wait6'
        if Tpace>=S1
            m_state='paceb4A6';
            pace=1;
            pace_round=pace_round+1;
            Tpace=0;
            return
        end
        if A6
            m_state='wait7';
            slowpath=0;
            if abs(t-lastAH)>5
                condition=5;
            else if pace_round==1
                    condition=6;
                else
                    condition=7;
                end
            end
        end
            return
    case 'paceb4A6'
        if Tpace>=100
            condition=3;
            terminated=1;
            return
        end
        if A6
            condition=4;
            slowpath=1;
            m_state='wait7';
        end
        return
    case 'wait7'
        if pace_round>=10
            condition=8;
            terminated=1;
            return
        end
        if A7
            lastHV=t;
            m_state='InitPace';
        end
        return
end
        
        
            