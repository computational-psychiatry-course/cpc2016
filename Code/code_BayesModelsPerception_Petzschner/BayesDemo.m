function BayesDemo


h = figure('color','white', 'DoubleBuffer','on');
hold on; grid on;


% likelihood
% m = 25;    % mean
% s = 0.58;  % standard deviation
m = 10;    % mean
s = 0.75;  % standard deviation


% prior
% m0 = 20;  % mean
% s0 = 1;   % standard deviation
m0 = 0;  % mean
s0 = 1;   % standard deviation


% posterior
s1 = sqrt(1 / (1 / s^2 + 1 / s0^2));
m1 = s1^2 * (m  / s^2 + m0 / s0^2);


% store parameters in structure
sets.meanlikeli = m;
sets.stdlikeli  = s;
sets.meanprior  = m0;
sets.stdprior   = s0;
sets.meanpost   = m1;
sets.stdpost    = s1;


% display distributions
% x = 15:0.01:30;
x = -10:0.01:20;
sets.val = x;
sets.h_likeli = plot(x,gauss(x,m,s),'b','linewidth',3);
sets.h_prior  = plot(x,gauss(x,m0,s0),'g','linewidth',3);
sets.h_post   = plot(x,gauss(x,m1,s1),'r','linewidth',3);
legend('Likelihood','Prior','Posterior');


setappdata(h,'bayes',sets);
doDispSliders(h)



function x = gauss(x,m,s)


x = 1 / (sqrt(2*pi)*s) * exp(-((x-m).^2)/(2*s^2));


function doDispSliders(h)
        d_h = figure('Name','Edit prior parameters', 'Resize','off',...
                'Units','pixels', 'Position',[ 50 50 395 70],...
                'Menubar','none', 'NumberTitle','off', 'HandleVisibility','off');
        val_h = uicontrol('Parent',d_h,'Style', 'Slider','Units',...
                'Pixels','Position',[10  10 290 20]);
        val_ed_h = uicontrol('Parent',d_h, 'Style','edit', 'Units','Pixels',...
                'String','', 'HorizontalAlignment','right',...
                'Position',[310,10,75,20],...
                'Callback',{@doValueEdit,h,d_h,val_h});
        % set(val_ed_h,'String',num2str(25));
        set(val_ed_h,'String',num2str(0));
%         set(val_h,'Value',25,'Min',15,'Max',30);
        set(val_h,'Value',0,'Min',-5,'Max',15);
        set(val_h,'Callback',{@doValueSlider,h,d_h,val_ed_h,'meanprior'});
        
        val_h = uicontrol('Parent',d_h,'Style', 'Slider','Units',...
                'Pixels','Position',[10  40 290 20]);
        val_ed_h = uicontrol('Parent',d_h, 'Style','edit', 'Units','Pixels',...
                'String','', 'HorizontalAlignment','right',...
                'Position',[310,40,75,20],...
                'Callback',{@doValueEdit,h,d_h,val_h});
        % set(val_ed_h,'String',num2str(0.58));
        set(val_ed_h,'String',num2str(1));
        % set(val_h,'Value',0.58,'Min',0.1,'Max',3);
        set(val_h,'Value',1,'Min',0.2,'Max',3);
        set(val_h,'Callback',{@doValueSlider,h,d_h,val_ed_h,'stdprior'});


function doValueSlider(a,dev,h,d_h,val_ed_h,name)
        val=get(a,'Value');
        set(val_ed_h,'String',num2str(val));
        sets=getappdata(h,'bayes');
    sets=setfield(sets,name,val);
    setappdata(h,'bayes',sets);
        doRedraw(a,dev,h)


function doValueEdit(a,dev,h,d_h,val_h)


function doRedraw(a,dev,h)
        sets=getappdata(h,'bayes');
        m = sets.meanlikeli;
        s = sets.stdlikeli;
        m0 = sets.meanprior;
        s0 = sets.stdprior;
        
        s1 = sqrt(1 / (1 / s^2 + 1 / s0^2));
        m1 = s1^2 * (m  / s^2 + m0 / s0^2);
        
        set(sets.h_likeli,'YData',gauss(sets.val,m,s));
        set(sets.h_prior,'YData',gauss(sets.val,m0,s0));
        set(sets.h_post,'YData',gauss(sets.val,m1,s1)); 
