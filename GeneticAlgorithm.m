function varargout = GeneticAlgorithmOptimizationGUI(varargin)
% GeneticAlgorithmOptimizationGUI MATLAB code for GeneticAlgorithmOptimizationGUI.fig
%      GeneticAlgorithmOptimizationGUI, by itself, creates a new GeneticAlgorithmOptimizationGUI or raises the existing
%      singleton*.
%
%      H = GeneticAlgorithmOptimizationGUI returns the handle to a new GeneticAlgorithmOptimizationGUI or the handle to
%      the existing singleton*.
%
%      GeneticAlgorithmOptimizationGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GeneticAlgorithmOptimizationGUI.M with the given input arguments.
%
%      GeneticAlgorithmOptimizationGUI('Property','Value',...) creates a new GeneticAlgorithmOptimizationGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GeneticAlgorithmOptimizationGUI before GeneticAlgorithmOptimizationGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GeneticAlgorithmOptimizationGUI_OpeningFcn via varargin.
%
%      *See GeneticAlgorithmOptimizationGUI Options on GUIDE's Tools menu.  Choose "GeneticAlgorithmOptimizationGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GeneticAlgorithmOptimizationGUI

% Last Modified by GUIDE v2.5 20-Jan-2015 14:27:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GeneticAlgorithmOptimizationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GeneticAlgorithmOptimizationGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GeneticAlgorithmOptimizationGUI is made visible.
function GeneticAlgorithmOptimizationGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GeneticAlgorithmOptimizationGUI (see VARARGIN)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
run_flag = 0;
stop_flag = 1;

error_flag_equation =  1 ;
error_flag_min_x1 =  1 ;
error_flag_min_x2 =  1; 
error_flag_max_x1 =  1;
error_flag_max_x2 =  1;

flag_GA_done = 0;

GA_type = 'maximize';

sort_method = 'descending';

error_flag_mut =  1; 
error_flag_num_pop =  1;
error_flag_iterations =  1; 

handles.error_flag_equation = error_flag_equation;
handles.error_flag_min_x1 = error_flag_min_x1;
handles.error_flag_min_x2 = error_flag_min_x2;
handles.error_flag_max_x1 = error_flag_max_x1;
handles.error_flag_max_x2 = error_flag_max_x2;

handles.error_flag_mut = error_flag_mut;
handles.error_flag_num_pop = error_flag_max_x1;
handles.error_flag_iterations = error_flag_iterations;
handles.flag_GA_done = flag_GA_done;

handles.GA_type = GA_type;
handles.sort_method = sort_method;

handles.run_flag = run_flag;
handles.stop_flag = stop_flag;



guidata(hObject,handles);

% --- Outputs from this function are returned to the command line.
function varargout = GeneticAlgorithmOptimizationGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes2);

run_flag = handles.run_flag;

stop_flag = handles.stop_flag;

error_flag_equation =  handles.error_flag_equation;
error_flag_min_x1 =  handles.error_flag_min_x1;
error_flag_min_x2 =  handles.error_flag_min_x2;
error_flag_max_x1 =  handles.error_flag_max_x1;
error_flag_max_x2 =  handles.error_flag_max_x2;

error_flag_mut =  handles.error_flag_mut;
error_flag_num_pop =  handles.error_flag_num_pop;
error_flag_iterations =  handles.error_flag_iterations;
guidata(hObject,handles);

if(error_flag_equation == 1 || error_flag_min_x1 == 1 || error_flag_min_x2 == 1 || error_flag_max_x1 == 1 || error_flag_max_x2 == 1 || error_flag_mut == 1 || error_flag_num_pop == 1 || error_flag_iterations == 1)
    
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Check Input Equation/Iterations/Population/Mutation Rate');

    return;

end

max_x2 = handles.max_x2;
max_x1 = handles.max_x1;
min_x2 = handles.min_x2;
min_x1 = handles.min_x1;

GA_type = handles.GA_type;

sort_method = handles.sort_method;

num_pop = handles.num_pop;

iterations = handles.iterations;

mut_rate = handles.mut_rate /100;

input_equation = handles.input_equation;

f=inline(input_equation,'x1','x2');

N = 50;

best_index = 1;

x1 = linspace(min_x1,max_x1,N);
x2 = linspace(min_x2,max_x2,N);

init_pop_rand_x1 = unifrnd(min_x1 , max_x1 , num_pop, 1);

init_pop_rand_x2 = unifrnd(min_x2 , max_x2 , num_pop, 1);

pop5 = [init_pop_rand_x1 init_pop_rand_x2];

set(handles.stop,'UserData',0);

if(strcmp(GA_type,'maximize'))
    
    sort_method = 'descending';
    
end

if(strcmp(GA_type,'minimize'))
    
    sort_method = 'ascending';
    
end

uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Running...');


for xi=1:iterations
    
    set(handles.axes2, 'units','pixels');
    current_axes_position = get(handles.axes2, 'Position')

    run_flag = 1;
    stop_flag = 0;
    handles.stop_flag = stop_flag;
    handles.run_flag = run_flag;
    guidata(hObject,handles);

      if(get(handles.stop,'UserData'))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Iterations Stopped by User');
          run_flag = 0;
          handles.run_flag = run_flag;
          stop_flag = 1;
          handles.searching = uicontrol('Style','text','Visible','on','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 80 current_axes_position(3) 20],'String','Search Stopped');
          handles.stop_flag = stop_flag;
          guidata(hObject,handles);

          
          break
      
      end
     
          
    for i=1:N
    
        for j=1:N
        
            X1(i,j) = x1(i);
            X2(i,j) = x2(j);
            Z(i,j) = f(X1(i,j),X2(i,j));
        
        end
    end
    
    axes(handles.axes2);
    hold on;

    for i=1:num_pop
    
        h(i) = plot(pop5(i),pop5(i,2),'*');
        
    end

    contour(X1,X2,Z,20);
    
    title('Population Searching for Global Minimum');
    xlabel('Variable X1');
    ylabel('Variable X2');

    hold off;

    pause(0.1);

    for i=1:num_pop
    
        if (ishandle(h(i)) && xi<iterations && not(get(handles.stop,'UserData')))
            
            delete(h(i)); 
   
        end
        
    end
    
    
    for i=1:num_pop
   
        pop2(i,1) = f(pop5(i,1),pop5(i,2));
    
    end
    
    pop3 = [pop5(:,1:2) pop2];
    
    pop4 = sortrows(pop3,3); % with all sorted rows and equation as last column
    
    if (strcmp(sort_method,'descending'))

        pop4 = flipdim(pop4,1);
        
    end
    
    if (strcmp(sort_method,'ascending'))
        
            pop4 = sortrows(pop3,3); % with all sorted rows and equation as last column
        
    end
    
    BestFun(best_index,:) = pop4(1,3);
    
    BestX1 = pop4(1,1);
    
    BestX2 = pop4(1,2);
    
    best_index = best_index+1;
    
    pop5 = [pop4(:,1:2)]; % only contains sorted rows without the equation as last column
    
    for i=2:2:num_pop/2
    
        B = rand();
    
        offspring(i,:) = [pop4(i,1)-B*pop4(i,1)+B*pop4(i+1,1), pop4(i+1,2)]; %mate 2 and 3
        offspring(i+1,:) = [pop4(i+1,1)+B*pop4(i,1)-B*pop4(i+1,1), pop4(i,2)]; 
    
    end
    
    B4 = rand();
    
    offspring1 = [pop4(1,1)-B4*pop4(1,1)+B4*pop4(end,1), pop4(end,2)]; % mate 1 and 12
    offspring12 = [pop4(end,1)+B4*pop4(1,1)-B4*pop4(end,1), pop4(1,2)];
    
    pop5(num_pop,1:2) = pop5(1,1:2); %save fittest sol to next gen
    
    for i=1:size(offspring(1,:))
        
        pop5(num_pop-i,1:2) = offspring(i+1);
        
    end
    
    pop5(num_pop/2-2,1:2) = offspring1;
    
    pop5(num_pop/2-1,1:2) = offspring12;

    mutations = randsample(setdiff(0:(num_pop/2)*mut_rate, 0), 1);
    
    for i=1:mutations
        
        mrow= randsample(setdiff(0:(num_pop/2)-4 , 0), 1);
        
        pop5(mrow,1) = unifrnd(min_x1 , max_x1, 1);
        
        pop5(mrow,2) = unifrnd(min_x2 , max_x2, 1);
        
    end
    
    for i=1:num_pop
   
        pop6(i,1) = f(pop5(i,1),pop5(i,2));
    
    end
    
    pop7 = [pop5(:,1:2) pop6];

    pop4 = sortrows(pop7,3);

    if( xi == iterations)
        
        uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Iterations Complete');

        
    end
    
    iteration_string = sprintf('Iteration %d', xi);
    X1_string = sprintf('Optimized value for X1 = %.5f', BestX1);
    X2_string = sprintf('Optimized value for X2 = %.5f', BestX2);
    Fun_string = sprintf('Optimized Function = %.5f', BestFun(xi));
    
    handles.searching = uicontrol('Style','text','Visible','on','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 80 current_axes_position(3) 20],'String','Searching...');
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 60 current_axes_position(3) 20],'String',iteration_string);
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 40 current_axes_position(3) 20],'String',X1_string);
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 20 current_axes_position(3) 20],'String',X2_string);
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 0 current_axes_position(3) 20],'String',Fun_string);
    
guidata(hObject,handles);
end
if(stop_flag == 0)
    handles.searching = uicontrol('Style','text','Visible','on','HorizontalAlignment','left','ForegroundColor','b','FontSize',10,'Position',[current_axes_position(1) 80 current_axes_position(3) 20],'String','Search Complete');
flag_GA_done = 1;
run_flag = 0;
hanldes.run_flag = run_flag;
handles.BestX1 = BestX1;
handles.BestX2 = BestX2;
handles.BestFun = BestFun;
handles.flag_GA_done = flag_GA_done;


guidata(hObject,handles);
end

flag_GA_done = 1;
run_flag = 0;
hanldes.run_flag = run_flag;
handles.BestX1 = BestX1;
handles.BestX2 = BestX2;
handles.BestFun = BestFun;
handles.flag_GA_done = flag_GA_done;


guidata(hObject,handles);

function equation_input_Callback(hObject, eventdata, handles)
% hObject    handle to equation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equation_input as text
%        str2double(get(hObject,'String')) returns contents of equation_input as a double

handles.input_equation = get(hObject,'string');  

input_equation = get(hObject,'string');

       if(isempty(input_equation))

          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please input the equation in terms of x1 and x2');

          error_flag_equation = 1;

       else 
           
           f=inline(input_equation,'x1','x2');

       N = 50;
       x1 = linspace(0,10,N);
       x2 = linspace(0,10,N);
       
       for i=1:N
           
           for j=1:N
        
            X1(i,j) = x1(i);
            X2(i,j) = x2(j);
            
            try
                Z(i,j) = f(X1(i,j),X2(i,j));
            catch
                uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please review syntax of input equation and ensure in terms of x1 and x2');
                error_flag_equation = 1;
                 handles.error_flag_equation = error_flag_equation;
                  guidata(hObject,handles);
          return;
          
            end
         
        
        end
    end
              uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Input Equation Correct');
    error_flag_equation = 0;
              handles.error_flag_equation = error_flag_equation;
       guidata(hObject,handles);
       
           
       end

% --- Executes during object creation, after setting all properties.
function equation_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function population_input_Callback(hObject, eventdata, handles)
% hObject    handle to population_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of population_input as text
%        str2double(get(hObject,'String')) returns contents of population_input as a double
       input = get(hObject,'String');
       num_pop = str2num(input);
       
       if(isempty(num_pop) | num_pop<20 | mod(num_pop,2) | ~isreal(num_pop))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real even positive integer larger than 20 for Population');

          error_flag_num_pop = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Population Correct');

           error_flag_num_pop = 0;
           
           
       end
           
       handles.error_flag_num_pop = error_flag_num_pop;
       
       handles.num_pop = num_pop;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function population_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to population_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function interations_Callback(hObject, eventdata, handles)
% hObject    handle to interations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interations as text
%        str2double(get(hObject,'String')) returns contents of interations as a double
       input = get(hObject,'String');
       iterations = str2num(input);
       
       if(isempty(iterations) | iterations<=0 | ~isreal(iterations))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for Iterations');

          error_flag_iterations = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Iterations Correct');

           error_flag_iterations = 0;
           
           
       end
           
       handles.error_flag_iterations = error_flag_iterations;
       
       handles.iterations = iterations;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function interations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function min_x1_Callback(hObject, eventdata, handles)
% hObject    handle to min_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_x1 as text
%        str2double(get(hObject,'String')) returns contents of min_x1 as a double

        max_x2 = handles.max_x2;
        max_x1 = handles.max_x1;
        min_x2 = handles.min_x2;
        
       input = get(hObject,'String');
       min_x1 = str2num(input);
       
       if(isempty(min_x1) | min_x1>max_x1 | ~isreal(min_x1))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for Min X1 and must be less than Max X1');
          error_flag_min_x1 = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Min X1 Correct');

           error_flag_min_x1 = 0;
           
           
       end
           
       handles.error_flag_min_x1 = error_flag_min_x1;

       handles.min_x1 = min_x1;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function min_x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_x1_Callback(hObject, eventdata, handles)
% hObject    handle to max_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_x1 as text
%        str2double(get(hObject,'String')) returns contents of max_x1 as a double
        max_x2 = handles.max_x2;
        min_x2 = handles.min_x2;
        min_x1 = handles.min_x1;       

       input = get(hObject,'String');
       max_x1 = str2num(input);
       
       if(isempty(max_x1) | max_x1<min_x1  | ~isreal(max_x1))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for Max X1 and must be more than Min X1');

          error_flag_max_x1 = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Max X1 Correct');

           error_flag_max_x1  = 0;
           
           
       end
           
       handles.error_flag_max_x1  = error_flag_max_x1 ;
       handles.max_x1 = max_x1;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function max_x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function min_x2_Callback(hObject, eventdata, handles)
% hObject    handle to min_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_x2 as text
%        str2double(get(hObject,'String')) returns contents of min_x2 as a double
        max_x2 = handles.max_x2;
        max_x1 = handles.max_x1;
        min_x1 = handles.min_x1;


       input = get(hObject,'String');
       min_x2 = str2num(input);
       
       if(isempty(min_x2) | min_x2>max_x2 | ~isreal(min_x2))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for Min X2 and must be less than Max X2');

          error_flag_min_x2 = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Min X2 Correct');

           error_flag_min_x2 = 0;
           
           
       end
           
       handles.error_flag_min_x2 = error_flag_min_x2;
       
       handles.min_x2 = min_x2;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function min_x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_x2_Callback(hObject, eventdata, handles)
% hObject    handle to max_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_x2 as text
%        str2double(get(hObject,'String')) returns contents of max_x2 as a double

        max_x1 = handles.max_x1;
        min_x2 = handles.min_x2;
        min_x1 = handles.min_x1;
        
       input = get(hObject,'String');
       max_x2 = str2num(input);
       
       if(isempty(max_x2) | max_x2<min_x2 | ~isreal(max_x2))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for Max X2 and must be more than Min X2');

          error_flag_max_x2 = 1;
       
       else 
           uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Max X2 Correct');

           error_flag_max_x2 = 0;

           
           
       end
           
       handles.error_flag_max_x2 = error_flag_max_x2;
       
       handles.max_x2 = max_x2;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function max_x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in plot_mesh.
function plot_mesh_Callback(hObject, eventdata, handles)
% hObject    handle to plot_mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

error_flag_equation =  handles.error_flag_equation;
error_flag_min_x1 =  handles.error_flag_min_x1;
error_flag_min_x2 =  handles.error_flag_min_x2;
error_flag_max_x1 =  handles.error_flag_max_x1;
error_flag_max_x2 =  handles.error_flag_max_x2;
guidata(hObject,handles);

        if(error_flag_equation == 1 || error_flag_min_x1 == 1 || error_flag_min_x2 == 1 || error_flag_max_x1 == 1 || error_flag_max_x2 == 1)
        
            uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Check Input Equation and Min/Max Values of X1/X2');

        
            return;
        end
        
uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Input Equation and Min/Max Values of X1/X2 Correct');
        

max_x2 = handles.max_x2;
max_x1 = handles.max_x1;
min_x2 = handles.min_x2;
min_x1 = handles.min_x1;

input_equation = handles.input_equation;

f=inline(input_equation,'x1','x2');


N = 50;

x1 = linspace(min_x1,max_x1,N);
x2 = linspace(min_x2,max_x2,N);

    for i=1:N
    
        for j=1:N
        
            X1(i,j) = x1(i);
            X2(i,j) = x2(j);
            Z(i,j) = f(X1(i,j),X2(i,j));
         
        
        end
    end
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Plotting Mesh...');

    mesh(X1,X2,Z,'Parent', handles.axes1);
    
    title('Function Mesh Plot','Parent', handles.axes1);
    xlabel('Variable X1','Parent', handles.axes1);
    ylabel('Variable X2','Parent', handles.axes1);
    zlabel('Z','Parent', handles.axes1);
    
    pause(0.5);

    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Plotted Mesh');

function mut_rate_Callback(hObject, eventdata, handles)
% hObject    handle to mut_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mut_rate as text
%        str2double(get(hObject,'String')) returns contents of mut_rate as a double
       
       input = get(hObject,'String');
       mut_rate = str2num(input);       
       if(isempty(mut_rate) || mut_rate > 100 || mut_rate < 10 || ~isreal(mut_rate))
          
          uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Please choose a real positive integer for mutation rate from 10% - 100%');

          error_flag_mut = 1;
       
       else 
                     uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Mutation Rate Correct');

           error_flag_mut = 0;
           
           
       end
           
       handles.error_flag_mut = error_flag_mut;
       handles.mut_rate = mut_rate;
       guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function mut_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mut_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.stop,'UserData',1)
    guidata(hObject,handles);

% --- Executes on button press in plot_fitvsgen.
function plot_fitvsgen_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fitvsgen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run_flag = handles.run_flag;

flag_GA_done = handles.flag_GA_done;
guidata(hObject,handles);

if(flag_GA_done == 0 && run_flag == 0)
        
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Run Genetic Algorithm before plotting Fitness Graph');
    
    return;

end

if(run_flag == 1 && flag_GA_done == 0)
        
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Stop Genetic Algorithm before plotting Fitness Graph');
    
    return;

end
     cla(handles.axes2);
    BestX1 =  handles.BestX1;
    BestX2 = handles.BestX2;
    BestFun = handles.BestFun;
    iterations = handles.iterations;
    
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Plotting Fitness vs Generations...');

    for i=1:size(BestFun)-1
    
        title('Fitness vs. Generations Plot','Parent', handles.axes2);
        xlabel('Generations','Parent', handles.axes2);
        ylabel('Fitness','Parent', handles.axes2);
    
        plot([i,i+1],[BestFun(i) BestFun(i+1)]);
    
        hold on;

    end
        
    pause(0.5);

        uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Plotted Fitness vs Generations');

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run_flag = handles.run_flag;
flag_GA_done = handles.flag_GA_done;
guidata(hObject,handles);

if(run_flag == 1 && flag_GA_done == 0)
 
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Stop Genetic Algorithm before Restarting');
    
    return;


end
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Reseting GUI and Parameters...');

    close(gcbf);
    close all;

    GeneticAlgorithmOptimizationGUI;

% --- Executes on selection change in GA_type.
function GA_type_Callback(hObject, eventdata, handles)
% hObject    handle to GA_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns GA_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from GA_type
GA_type = handles.GA_type;
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val};
case 'Maximize Function' % User selects peaks.   
    GA_type = 'maximize';
case 'Minimize Function' % User selects membrane.
    GA_type = 'minimize';
end

% Save the handles structure.

handles.GA_type = GA_type;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function GA_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GA_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run_flag = handles.run_flag;
flag_GA_done = handles.flag_GA_done;
guidata(hObject,handles);

if(run_flag == 1 && flag_GA_done == 0)
        
    uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Stop Genetic Algorithm before Exiting');
    
    return;
    


end

uicontrol('Style','text','HorizontalAlignment','left','ForegroundColor','r','FontSize',10,'Position',[10 0 600 20],'String','Exiting GUI...');
close(gcbf); 
close all;
