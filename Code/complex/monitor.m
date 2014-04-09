function [pace,condition]=monitor(S1,A1,A2,A6,A7)

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
            lastAV=t;
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
        
            