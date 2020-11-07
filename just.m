%ss=load('sd.mat');
%bd=length(ss.data);
%ss.len.data(2)
%Pre-processing
%for i = 1 : 1 : bd
%if i == 1
%m(i)=ss.data(i+1)-ss.data(i);
%end
%if i > 1
%m(i)= ss.data(i)-ss.data(i-1);
%end
%end
%filename='m.mat';
%save(filename)

%QRS Detection
load('denoise.mat');
plot(denoise);
grid off
a=max(denoise);
b=denoise(864);
count=0;
i=1;
while i < length(denoise)
    next=1;
    past=0;
    if denoise(i)>(0.60*a) 
        while (denoise(i+past)< denoise(i+next)) || (denoise(i+past)== denoise(i+next))
            %denoise(i+past)
            %denoise(i+next)
            past=next;
            %next
            next=next+1;
        end
        count=count+1;
        pos_R(count)=i+next-1; 
        val_R(count)=denoise(i+next-1);
        i=i+100;
    end
    i=i+1;
end
m=length(pos_R);
%stem(pos_R,val_R);

%determination Q position end
count=0;
for x=1:1:m
    y=1;
    while (denoise(pos_R(x))- denoise(pos_R(x)-y)) < denoise(pos_R(x))
        y=y+1;
    end
    count=count+1;
    pos_Q_end(count)=pos_R(x)-y;
end

%determination Q position start

count=0;
for x=1:1:m
    y=1;
    while (denoise(pos_Q_end(x))- denoise(pos_Q_end(x)-y)) > denoise(pos_Q_end(x))
        y=y+1;
    end
    count=count+1;
    pos_Q_start(count)=pos_Q_end(x)-y;
end
     

% Determination Of R end

count=0;
for x=1:1:m
    y=1;
    while (denoise(pos_R(x))- denoise(pos_R(x)+y)) < denoise(pos_R(x))
        y=y+1;
    end
    count=count+1;
    pos_R_end(count)=pos_R(x)+y;
end

% Determinatio of s end

count=0;
for x=1:1:m
    y=1;
    while (denoise(pos_R_end(x))- denoise(pos_R_end(x)+y)) > denoise(pos_R_end(x))
        y=y+1;
    end
    count=count+1;
    pos_S_start(count)=pos_R_end(x)+y;
end

% Determination of s
count=0;
for x=1:1:m
    y=1;
    while (denoise(pos_S_start(x)+y)>0.0008)
        y=y+1;
    end
    count=count+1;
    pos_S_end(count)=pos_S_start(x)+y;
end

%QES Detection
count=0;
total_QRS=0;
for x=1:1:m
    count=count+1;
    time_QRS(count)=pos_S_end(x)-pos_Q_start(x);
    total_QRS=total_QRS+time_QRS(count);
end
 mean_qrs=total_QRS/m;
 %mean_qrs
 count=m;
 diff=0;
 for i=1:1:m
     x=mean_qrs;
     y=time_QRS(i);
     
     if (x>y) 
     diff = (x-y);
     end
     
     if (y>x)
     diff = (y-x);
     end
     
     if (x==y)
    diff = 0;
     end
      
     if diff>10
         count=count-1;
         total_QRS=total_QRS-time_QRS(i);
     end
         
 end
 
 QRS=total_QRS/count;
 QRS
 %real_QRS

% Determination of T wave 
 g=0;
for x=1:1:m-1
    po=0;
    qo=0;  
    dd=pos_S_end(x);
    ff=pos_Q_start(x+1);
   for y=dd:1:ff
        y=y+1;
        twave=denoise(y);
        if twave>0.0 && twave > po
           po=twave;
           do=y;
           
        end
        if twave<0.0 && twave < qo
            qo=twave;
            co=y;
        end

   end
            g=g+1;
            %tmin(g)=co;
            %tmax(g)=do;
            qo=-(qo);
            if qo>po
               tmain(g)=co;
               %T is inverse
               test=0;
            end
            if po>qo
                tmain(g)=do;
                %T is normal
                test=1;
                
            end

end
% determination of t end
if test==0
tlen=length(tmain);
count=0;
for x=1:1:tlen
    y=1;
    while denoise(tmain(x)+y)<0.0001
        y=y+1;
    end
    count=count+1;
    pos_T_end(count)=tmain(x)+y;
    
end

%determination of t start

count=0;
for x=1:1:tlen
    y=1;
    while denoise(tmain(x)-y)<0.0001
        y=y+1;
    end
    count=count+1;
    pos_T_start(count)=tmain(x)-y;
    
end
end

if test==1
tlen=length(tmain);
count=0;
for x=1:1:tlen
    y=1;
    while denoise(tmain(x)+y)>-0.0001
        y=y+1;
    end
    count=count+1;
    pos_T_end(count)=tmain(x)+y;
    
end

%determination of t start

count=0;
for x=1:1:tlen
    y=1;
    while denoise(tmain(x)-y)>-0.0001
        y=y+1;
        if (tmain(x)-y)<1
            break;
        end
    end
    count=count+1;
    pos_T_start(count)=tmain(x)-y;
    
end   
    
end
% threshold value
 count=0;
total_t=0;
for x=1:1:tlen
    count=count+1;
    time_t(count)=pos_T_end(x)-pos_T_start(x);
    total_t=total_t+time_t(count);
end
 mean_t=total_t/tlen;
% mean_t
 count=tlen;
 diff=0;
 for i=1:1:tlen
     x=mean_t;
     y=time_t(i);
     
     if (x>y) 
     diff = (x-y);
     end
     
     if (y>x)
     diff = (y-x);
     end
     
     if (x==y)
    diff = 0;
     end
      
     if diff>10
         count=count-1;
         total_t=total_t-time_t(i);
     end
         
 end
 
 real_t=total_t/count;

%real_t

%-------------End of T wave--------------------------------

%------------determine R-R interval------------------------
n=length(pos_R);
time=pos_R(n)-pos_R(1);
p=n-1;
rr=time/p;
RR=rr/1000;
RR
trlen=0;
for x=1:1:n
    rlen=denoise(pos_R(x));
    trlen=rlen+trlen;
end
rlength=(trlen/n)*500;
rlength
%------End of R-R Interval---------------

%-------Determination of S-T segment-------
 count=0;
total_st=0;
for x=1:1:tlen
    count=count+1;
    time_st(count)=pos_T_start(x)-pos_S_end(x);
    total_st=total_st+time_st(count);
end
 mean_st=total_st/tlen;
% mean_st
 count=tlen;
 diff=0;
 for i=1:1:tlen
     x=mean_t;
     y=time_t(i);
     
     if (x>y) 
     diff = (x-y);
     end
     
     if (y>x)
     diff = (y-x);
     end
     
     if (x==y)
    diff = 0;
     end
      
     if diff>10
         count=count-1;
         total_st=total_st-time_st(i);
     end
         
 end
 
 ST=total_st/count;
 ST
 %--------END of ST segment---------------
 %----------Determination of Q-T Interval---------
 
 count=0;
total_qt=0;
for x=1:1:tlen
    count=count+1;
    time_qt(count)=pos_T_end(x)-pos_Q_start(x);
    total_qt=total_qt+time_qt(count);
end
 mean_qt=total_qt/tlen;
% mean_qt
 count=tlen;
 diff=0;
 for i=1:1:tlen
     x=mean_t;
     y=time_t(i);
     
     if (x>y) 
     diff = (x-y);
     end
     
     if (y>x)
     diff = (y-x);
     end
     
     if (x==y)
    diff = 0;
     end
      
     if diff>10
         count=count-1;
         total_qt=total_qt-time_qt(i);
     end
         
 end
 
 QT=total_qt/count;
 QT
 %-----------END of Q-T Interval------------------
 %-----------determination of Q interval----------
count=0;
total_t=0;
for x=1:1:tlen
    count=count+1;
    time_t(count)=pos_Q_end(x)- pos_Q_start(x);
    total_t=total_t+time_t(count);
end
 mean_t=total_t/tlen;
% mean_qt
 count=tlen;
 diff=0;
 for i=1:1:tlen
     x=mean_t;
     y=time_t(i);
     
     if (x>y) 
     diff = (x-y);
     end
     
     if (y>x)
     diff = (y-x);
     end
     
     if (x==y)
    diff = 0;
     end
      
     if diff>10
         count=count-1;
         total_t=total_t-time_t(i);
     end
         
 end
  Q=total_t/count;
 Q
  %-----------END of Q Interval------------------
 QT=total_qt/count;
 QT
 HR = 60/RR;
 QRS = QRS/1000;
 ST = ST/1000;
 QT = QT/1000;
 Q = Q/1000;
 mS = 'ms';
 sec = 's';
 sTstring = num2str(ST);
 qTstring = num2str(QT);
 qrsString = num2str(QRS);
 sT = strcat(sTstring,mS);
 qT = strcat(qTstring,mS);
 qRS = strcat(qrsString,mS);
 rRstring = num2str(RR);
 rRws = strcat(rRstring,sec);
 
 %-----------END of Q-T Interval------------------
 %--set Data file calling

%set_Data


