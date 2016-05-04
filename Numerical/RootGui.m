function varargout = RootGui(varargin)
% ROOTGUI MATLAB code for RootGui.fig
%      ROOTGUI, by itself, creates a new ROOTGUI or raises the existing
%      singleton*.
%
%      H = ROOTGUI returns the handle to a new ROOTGUI or the handle to
%      the existing singleton*.
%
%      ROOTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROOTGUI.M with the given input arguments.
%
%      ROOTGUI('Property','Value',...) creates a new ROOTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RootGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RootGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RootGui

% Last Modified by GUIDE v2.5 03-May-2016 21:57:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RootGui_OpeningFcn, ...
                   'gui_OutputFcn',  @RootGui_OutputFcn, ...
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


% --- Executes just before RootGui is made visible.
function RootGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no o args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RootGui (see VARARGIN)

% Choose default command line o for RootGui
handles.o = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RootGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RootGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning o args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line o from handles structure
varargout{1} = handles.o;



function time_ans_Callback(hObject, eventdata, handles)
% hObject    handle to time_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_ans as text
%        str2double(get(hObject,'String')) returns contents of time_ans as a double


% --- Executes during object creation, after setting all properties.
function time_ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lower_bound_Callback(hObject, eventdata, handles)
% hObject    handle to lower_bound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lower_bound as text
%        str2double(get(hObject,'String')) returns contents of lower_bound as a double


% --- Executes during object creation, after setting all properties.
function lower_bound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lower_bound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in solve_button.
function solve_button_Callback(hObject, eventdata, handles)
% hObject    handle to solve_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
import model.RootSolver

disp('hello');
equ = get(handles.input_equation, 'String');
equ = strcat('@(x)', equ);
f = str2func(equ);
lower = get(handles.lower_bound, 'String');
lower = str2num(lower);
upper = get(handles.upper_bound, 'String');
upper = str2num(upper);
iter = get(handles.num_iter, 'String');
iter = str2num(iter);
pre = get(handles.pre, 'String');
pre = str2num(pre);
solver = RootSolver(f, iter, pre);
column_name = {'Execution Time','Precision','Theoretical Error','Number Of Iterations','Roots'};
 switch get(get(handles.method_selector,'SelectedObject'),'Tag')
     
       case 'false',   
            [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.FalsePosition(lower, upper);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N','Ex'};
              a = [theoError;precision;aproxRoot;numOfIterations;executionTime];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'Lower','Upper','mid','f(mid)','relativeError'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
              fplot(f,[lower,upper]);
              %line([lower lower],[1 100]);
              % line([upper upper],[1 100]);
           end
           
      case 'fixed',   
            [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.FixedPoint(lower);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N','Ex'};
              a = [theoError;precision;aproxRoot;numOfIterations;executionTime];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'guess', 'relativeError'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
              str = '@(x)x';
              g = str2func(str);
              fplot(f,[lower,upper]);
              hold on
               fplot(g,[lower,upper]);
               hold off
              %line([lower lower],[1 100]);
              % line([upper upper],[1 100]);
           end
     
      case 'secant',          
           [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.Secant(lower, upper);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N','Ex'};
              a = [theoError;precision;aproxRoot;numOfIterations;executionTime];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'firstGuess','secondGuess','precision'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
              syms x;
              df = diff(f, x);
              g = inline(df);
              fplot(f,[lower upper]);
              hold on
              fplot(g,[lower upper]);
              hold off
           end
      case 'veta',  
            
           [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.BrigeVeta(lower);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N','Ex'};
              a = [theoError;precision;aproxRoot;numOfIterations;executionTime];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'a','b','c'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
             fplot(f,[lower upper]);
           end
          
           
     case 'general',
          [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.getAllRoots(lower, upper);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N'};
              a = [theoError;precision;aproxRoot;numOfIterations];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'Lower','Upper','mid','f(mid)','relativeError'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
             fplot(f,[lower upper]);
           end
         
         
      case 'newton',  
          [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.Newton(lower);
           if(strcmp(message, 'Success'))
              a = [executionTime precision theoError numOfIterations aproxRoot];
              set(handles.output2, 'Data', a, 'ColumnName', column_name);
              columnname = {'previous', 'current', 'precision'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
              syms x;
              df = diff(f, x);
              g = inline(df);
              fplot(f,[lower upper]);
              hold on
              fplot(g,[lower upper]);
              hold off
           end
      case 'bisection', 
           [numOfIterations,executionTime,allIteration,aproxRoot,precision,theoError,message] = solver.Bisection(lower, upper);
           if(strcmp(message, 'Success'))
              rownames = {'TE','P','R','N','Ex'};
              a = [theoError;precision;aproxRoot;numOfIterations;executionTime];
              set(handles.output2, 'Data', a, 'RowName',rownames);
              columnname = {'Lower','Upper','mid','f(mid)','relativeError'};
              set(handles.output, 'Data', allIteration, 'ColumnName', columnname);
              fplot(f,[lower,upper]);
              %line([lower lower],[1 100]);
              % line([upper upper],[1 100]);
           end
  end





disp(equ);
%set(handles.output, 'String', equ);

function upper_bound_Callback(hObject, eventdata, handles)
% hObject    handle to upper_bound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upper_bound as text
%        str2double(get(hObject,'String')) returns contents of upper_bound as a double


% --- Executes during object creation, after setting all properties.
function upper_bound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upper_bound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_iter_Callback(hObject, eventdata, handles)
% hObject    handle to num_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_iter as text
%        str2double(get(hObject,'String')) returns contents of num_iter as a double


% --- Executes during object creation, after setting all properties.
function num_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pre_Callback(hObject, eventdata, handles)
% hObject    handle to pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre as text
%        str2double(get(hObject,'String')) returns contents of pre as a double


% --- Executes during object creation, after setting all properties.
function pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_ans_Callback(hObject, eventdata, handles)
% hObject    handle to iter_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter_ans as text
%        str2double(get(hObject,'String')) returns contents of iter_ans as a double


% --- Executes during object creation, after setting all properties.
function iter_ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_equation_Callback(hObject, eventdata, handles)
% hObject    handle to input_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_equation as text
%        str2double(get(hObject,'String')) returns contents of input_equation as a double
equ = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function input_equation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on solve_button and none of its controls.
function solve_button_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to solve_button (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output as text
%        str2double(get(hObject,'String')) returns contents of output as a double


% --- Executes during object creation, after setting all properties.
function output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pre_ans_Callback(hObject, eventdata, handles)
% hObject    handle to pre_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre_ans as text
%        str2double(get(hObject,'String')) returns contents of pre_ans as a double


% --- Executes during object creation, after setting all properties.
function pre_ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theo_ans_Callback(hObject, eventdata, handles)
% hObject    handle to theo_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theo_ans as text
%        str2double(get(hObject,'String')) returns contents of theo_ans as a double


% --- Executes during object creation, after setting all properties.
function theo_ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theo_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
