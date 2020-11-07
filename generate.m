%ss=load('tushar_vai.mat');
bd=length(File.data);
%ss.len.data(2)
%Pre-processing
for i = 1 : 1 : bd
if i == 1
m(i)=File.data(i+1)-File.data(i);
end
if i > 1
m(i)= File.data(i)-File.data(i-1);
end
end
%plot(m);
filename='m.mat';
save(filename)
load m.mat;
denoise = func_denoise_wp1d(m);
%denoise = sigDEN;
%save('denoise.mat','sigDEN');
%ss = load('denoise.mat');
%---For first Graph
axes(handles.axes2);
plot(denoise(1:2000));
grid on
axis tight
%zoom on

% ------Just File Calling-----%
just
