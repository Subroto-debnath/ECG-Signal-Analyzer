normalQrs = 0.12;
%%----------------
set(handles.rR,'String',rRws);
set(handles.qRs,'String',qRS);
set(handles.heartBeat,'String',HR);
set(handles.sT,'String',sT);
set(handles.qT,'String',qT);
sT
%------ Disease Detection Block------%
if(HR>=100)
    set(handles.disease,'String','Sinus Tachycardia');
    set(handles.percent,'String','99%');
    set(handles.othersTag,'String','1%');
    set(handles.others,'String','Others');
elseif(HR<=60)
    set(handles.disease,'String','Sinus Bradycardia');
    set(handles.others,'String','Others');
    set(handles.percent,'String','99%');
    set(handles.othersTag,'String','1%');
     
elseif(HR>=150 && HR<=250 && QRS < normalQrs)
    
     set(handles.disease,'String','Supraventricular Tachycardia');%P absent,qrs narrow
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(HR>=140 && HR <=220 && QRS == normalQrs)
     set(handles.disease,'String','Atrial Tachycardia');%P small,abnormal
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(QRS>0.12 && test==0)% p absent
     set(handles.disease,'String','Ventricular Ectopic');
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(QRS>0.14 && HR>=101 && HR<=220)
     set(handles.disease,'String','Ventricular Tachycardia');
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(QRS > normalQrs && QT>0.43)
     set(handles.disease,'String','Polymorphic Ventricular Tachycardia(Check if QRS is bizzare)');
     set(handles.percent,'String','90%');
     set(handles.othersTag,'String','10%');
     set(handles.others,'String','Others');
elseif(QRS>0.12)
     set(handles.disease,'String','Left Or Right Bundle Branch Block (Check qrs is like M)');
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(ST>.08 && Q>.04 && test==0)
     set(handles.disease,'String','Myocardial Infarction');
     set(handles.percent,'String','90%');
     set(handles.othersTag,'String','10%');
     set(handles.others,'String','Others');
elseif(HR>=100 && test==0)
     set(handles.disease,'String','Pulmonary Embolism');
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(QT>0.43 && ST>.08)
     set(handles.disease,'String','Hyperthyroidism');
     set(handles.percent,'String','80%');
     set(handles.othersTag,'String','20%');
     set(handles.others,'String','Others');
elseif(QT<0.35 && ST<.08 && QRS>normalQrs )
    set(handles.disease,'String','Hypercalcaemia');
    set(handles.percent,'String','80%');
    set(handles.othersTag,'String','20%');
    set(handles.others,'String','Others');
else
    set(handles.disease,'String','Normal');
    set(handles.percent,'String','99%');
    set(handles.othersTag,'String','1%');
    set(handles.others,'String','Others');
end