function varargout = IntrplGui(varargin)
% INTRPLGUI MATLAB code for IntrplGui.fig
%      INTRPLGUI, by itself, creates a new INTRPLGUI or raises the existing
%      singleton*.
%
%      H = INTRPLGUI returns the handle to a new INTRPLGUI or the handle to
%      the existing singleton*.
%
%      INTRPLGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRPLGUI.M with the given input arguments.
%
%      INTRPLGUI('Property','Value',...) creates a new INTRPLGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntrplGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IntrplGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntrplGui

% Last Modified by GUIDE v2.5 09-May-2016 22:58:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntrplGui_OpeningFcn, ...
                   'gui_OutputFcn',  @IntrplGui_OutputFcn, ...
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


% --- Executes just before IntrplGui is made visible.
function IntrplGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntrplGui (see VARARGIN)

% Choose default command line output for IntrplGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% clear tables of points and queries
data=get(handles.uitable1, 'data');
data(:,:) = [];
set(handles.uitable1, 'data', data);
data=get(handles.uitable2, 'data');
data(:,:) = [];
set(handles.uitable2, 'data', data);



% UIWAIT makes IntrplGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IntrplGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% add new row
 data=get(handles.uitable1, 'data');
 Xcoord = str2double(get(handles.edit1, 'String'));
 Ycoord = str2double(get(handles.edit2, 'String'));
 data(end+1,:)={Xcoord, Ycoord};
 set(handles.uitable1, 'data', data);
 



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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


% --- Executes on key press with focus on pushbutton2 and none of its controls.
function pushbutton2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

uBound = realmin;
lBound = realmax;
%constructing points array
data=get(handles.uitable1, 'data');
pointsTableSize = size(data);
points = zeros(pointsTableSize(1), 2);
for index = 1 : pointsTableSize(1)
    points(index, 1) = cell2mat(data(index, 1));
    points(index, 2) = cell2mat(data(index, 2));
    uBound = max(uBound, points(index, 1));
    lBound = min(lBound, points(index, 1));
end

% constructing queries array
data=get(handles.uitable2, 'data');
queriesTableSize = size(data);
queries = zeros(1, queriesTableSize(1));
for index = 1 : queriesTableSize(1)
    queries(1, index) = cell2mat(data(index, 1));
end


import model.*;
newtonSolver = Interpolation(points);
[exeTime, polynomial, solution, message] = newtonSolver.Newton(queries);
polymomialAsString = char(polynomial);
set(handles.text5, 'String', polymomialAsString);
drawnow();

% applying interpolation to queries
data=get(handles.uitable2, 'data');
solutionArraySize = size(solution);
for index = 1 : solutionArraySize(2)
    if ~isnan(solution(index))
        data(index, 2) = {solution(index)};
    else
        data(index, 2) = {'   undefined'};
    end
end
solution
set(handles.uitable2, 'data', data);
drawnow();

set(handles.text8, 'String', message);
set(handles.text10, 'String', exeTime);
drawnow();
axes(handles.axes1);
if lBound ~= uBound && lBound ~= realmax 
    ezplot(polynomial, [lBound, uBound]);
end
drawnow();
hold;
% draw points
for i = 1 : pointsTableSize(1)
    scatter(points(i,1), points(i,2), 100, [0 0 1], 'filled');
end
% draw queries
for i = 1 : solutionArraySize(2)
    if ~isnan(solution(1, i))
        scatter(queries(1, i), solution(1, i), 100, 200, 'filled');
    end
end
hold;





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uBound = realmin;
lBound = realmax;
%constructing points array
data=get(handles.uitable1, 'data');
pointsTableSize = size(data);
points = zeros(pointsTableSize(1), 2);
for index = 1 : pointsTableSize(1)
    points(index, 1) = cell2mat(data(index, 1));
    points(index, 2) = cell2mat(data(index, 2));
    uBound = max(uBound, points(index, 1));
    lBound = min(lBound, points(index, 1));
end

% constructing queries array
data=get(handles.uitable2, 'data');
queriesTableSize = size(data);
queries = zeros(1, queriesTableSize(1));
for index = 1 : queriesTableSize(1)
    queries(1, index) = cell2mat(data(index, 1));
end


import model.*;
newtonSolver = Interpolation(points);
[exeTime, polynomial, solution, message] = newtonSolver.Lagrang(queries);
polymomialAsString = char(polynomial);
set(handles.text5, 'String', polymomialAsString);
drawnow();

% applying interpolation to queries
data=get(handles.uitable2, 'data');
solutionArraySize = size(solution);
for index = 1 : solutionArraySize(2)
    if ~isnan(solution(index))
        data(index, 2) = {solution(index)};
    else
        data(index, 2) = {'   undefined'};
    end
end
solution
set(handles.uitable2, 'data', data);
drawnow();

set(handles.text8, 'String', message);
set(handles.text10, 'String', exeTime);
drawnow();
axes(handles.axes1);
if lBound ~= uBound && lBound ~= realmax 
    ezplot(polynomial, [lBound, uBound]);
end
drawnow();
hold;
% draw points
for i = 1 : pointsTableSize(1)
    scatter(points(i,1), points(i,2), 100, [0 0 1], 'filled');
end
% draw queries
for i = 1 : solutionArraySize(2)
    if ~isnan(solution(1, i))
        scatter(queries(1, i), solution(1, i), 100, 200, 'filled');
    end
end
hold;



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 data=get(handles.uitable2, 'data');
 Xcoord = str2double(get(handles.edit4, 'String'));
 data(end+1,:)={Xcoord, '   undefined'};
 set(handles.uitable2, 'data', data);




% --- Executes on key press with focus on pushbutton4 and none of its controls.
function pushbutton4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on pushbutton3 and none of its controls.
function pushbutton3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1, 'data');
data(:,:) = [];
set(handles.uitable1, 'data', data);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable2, 'data');
data(:,:) = [];
set(handles.uitable2, 'data', data);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

points = scan();
sizeOfPoints = size(points);
%data=get(handles.uitable1, 'data');
%data(:,:) = [];
data = cell(sizeOfPoints(1), 2);
for index = 1 : sizeOfPoints(1)
    data(index,:)={points(index, 1), points(index, 2)};
end
 set(handles.uitable1, 'data', data);
    
