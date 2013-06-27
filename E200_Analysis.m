function varargout = E200_Analysis(varargin)
% E200_ANALYSIS M-file for E200_Analysis.fig
%      E200_ANALYSIS, by itself, creates a new E200_ANALYSIS or raises the existing
%      singleton*.
%
%      H = E200_ANALYSIS returns the handle to a new E200_ANALYSIS or the handle to
%      the existing singleton*.
%
%      E200_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in E200_ANALYSIS.M with the given input arguments.
%
%      E200_ANALYSIS('Property','Value',...) creates a new E200_ANALYSIS or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before E200_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to E200_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help E200_Analysis

% Last Modified by GUIDE v2.5 12-May-2013 23:16:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @E200_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @E200_Analysis_OutputFcn, ...
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

% --- Executes just before E200_Analysis is made visible.
function E200_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to E200_Analysis (see VARARGIN)

% Choose default command line output for E200_Analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes E200_Analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = E200_Analysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density as text
%        str2double(get(hObject,'String')) returns contents of density as a double
density = str2double(get(hObject, 'String'));
if isnan(density)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new density value
handles.metricdata.density = density;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double
volume = str2double(get(hObject, 'String'));
if isnan(volume)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.metricdata.volume = volume;
guidata(hObject,handles)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mass = handles.metricdata.density * handles.metricdata.volume;
set(handles.mass, 'String', mass);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui(gcbf, handles, true);

% --- Executes when selected object changed in unitgroup.
function unitgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.english)
    set(handles.text4, 'String', 'lb/cu.in');
    set(handles.text5, 'String', 'cu.in');
    set(handles.text6, 'String', 'lb');
else
    set(handles.text4, 'String', 'kg/cu.m');
    set(handles.text5, 'String', 'cu.m');
    set(handles.text6, 'String', 'kg');
end

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

% Update handles structure
guidata(handles.figure1, handles);

function currentfile_Callback(hObject, eventdata, handles)
% hObject    handle to currentfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currentfile as text
%        str2double(get(hObject,'String')) returns contents of currentfile as a double
display('hi!')

% --- Executes during object creation, after setting all properties.
function currentfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over currentfile.
function currentfile_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to currentfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OpenDataset.
function OpenDataset_Callback(hObject, eventdata, handles)
% hObject    handle to OpenDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global dirs;
global gl;

% Extract most recent file location
searchpath = '/nas/nas-li20-pm01/E200/';
dirs       = dir(searchpath);
first      = dirs(3).name;
searchpath = [searchpath first '/'];
dirs       = dir(searchpath);
second     = dirs(end).name;
searchpath = [searchpath second '/'];
dirs       = dir(searchpath);
third      = dirs(end).name;
searchpath = [searchpath third '/'];

searchlist = {{'scan_info.mat','scan'},{'filenames.mat','daq'}};

settype='none';
filtstr='';
for searchstr=searchlist
    desiredfiles=dir(fullfile(searchpath,['*' searchstr{1}{1}]));
    if size(desiredfiles,1)>0
        settype=searchstr{1}{2};
        filtstr=searchstr{1}{1};
        break;
    end
end

switch settype
    case 'scan'
        defaultfile=[third '_' filtstr];
    case 'daq'
        defaultfile=desiredfiles(1).name;
    case 'none'
        defaultfile='';
end

curpath=pwd;
cd(searchpath);
[Filename,Pathname,FilterIndex]=uigetfile(['*' filtstr],'Open E200 scan_info file',defaultfile);
cd(curpath);

% Pathname='/nas/nas-li20-pm01/E200/2013/20130511/E200_11071/';
% Filename='E200_11071_scan_info.mat';

% gl.filename=Filename;

settype='none';
filtstr='';
if (Filename~=0)
    for searchstr=searchlist
        if ~isempty(strfind(Filename,searchstr{1}{1}))
            handles.settype=searchstr{1}{2};
            handles.filtstr=searchstr{1}{1};
            guidata(hObject,handles);
        end
    end
else
    error('File not selected');
end

% Type-specific Initialization
switch handles.settype
    case 'scan'

        % Load scan_info file
        load([Pathname Filename]);
        
        % Load first filename file
        dirs=dir(fullfile(Pathname,'*_2013*.mat'));
        load([Pathname dirs(1).name]);

        n_steps=size(scan_info,2);
        set(handles.Stepstaken,'String',n_steps);
        set(handles.Stepnumberslider,'Min',1);
        set(handles.Stepnumberslider,'Max',n_steps);
        set(handles.Stepnumberslider,'Value',1);
        set(handles.Stepnumberslider,'SliderStep',[1/n_steps,10/n_steps]);
        set(handles.Stepnumberslider,'Enable','On');
        set(handles.Stepnumbertext,'String',1);
        set(handles.Stepnumbertext,'Enable','on');

        handles.scan.scan_info=scan_info;
        handles.scan.n_steps=n_steps;
        
    case 'daq'
        
        % Load file
        load([Pathname Filename(1:end-14) '.mat']);
        load([Pathname Filename]);
        
        handles.daq.filenames=filenames;
        
        gl.file=[Pathname Filename];
        
        set(handles.Stepstaken,'String','NOT A SCAN: NO STEPS!');
        
        set(handles.Stepnumberslider,'Enable','Off');
        set(handles.Stepnumbertext,'String','N/A');
    case 'none'
end

% All file initializations
if ~strcmp(handles.settype,'none')
    
    set(handles.Cams,'String',{param.cams{:,1}});
    % set(handles.Cams,'Max',size(param.cams,1));
    
    set(handles.currentfile,'String',Pathname);
    set(handles.FileDate,'String',[second(5:6) '-' second(7:8) '-' second(1:4)]);
    
    set(handles.Shotsperstep,'String',param.n_shot);
    set(handles.Shotnumberslider,'Min',1);
    set(handles.Shotnumberslider,'Max',param.n_shot);
    set(handles.Shotnumberslider,'Value',1);
    set(handles.Shotnumberslider,'SliderStep',[1/param.n_shot,10/param.n_shot]);
    set(handles.Shotnumberslider,'Enable','off');
    set(handles.Shotnumbertext,'String','');
    set(handles.Usebg,'Enable','off');

    % Turn things off.
    cla(handles.fig1);
    
    set(handles.Comment,'String',param.comt_str);

    handles.param=param;
    handles.cam_back=cam_back;
    
    gl.param=param;
    gl.Pathname=Pathname;
    gl.dirs=dirs;
    gl.cam_back=cam_back;
    gl.handles=handles;
end

guidata(hObject,handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over OpenDataset.
function OpenDataset_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to OpenDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function FileDate_Callback(hObject, eventdata, handles)
% hObject    handle to FileDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileDate as text
%        str2double(get(hObject,'String')) returns contents of FileDate as a double


% --- Executes during object creation, after setting all properties.
function FileDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FileTime_Callback(hObject, eventdata, handles)
% hObject    handle to FileTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileTime as text
%        str2double(get(hObject,'String')) returns contents of FileTime as a double


% --- Executes during object creation, after setting all properties.
function FileTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Cams.
function Cams_Callback(hObject, eventdata, handles)
% hObject    handle to Cams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Cams contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Cams
try
    handles=rmfield(handles,'maxsubpixel');
end
handles=loadimages(hObject,handles);
plotpanel(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Cams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function OpenDataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OpenDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function Stepstaken_Callback(hObject, eventdata, handles)
% hObject    handle to Stepstaken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stepstaken as text
%        str2double(get(hObject,'String')) returns contents of Stepstaken as a double


% --- Executes during object creation, after setting all properties.
function Stepstaken_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stepstaken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Shotsperstep_Callback(hObject, eventdata, handles)
% hObject    handle to Shotsperstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Shotsperstep as text
%        str2double(get(hObject,'String')) returns contents of Shotsperstep as a double


% --- Executes during object creation, after setting all properties.
function Shotsperstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shotsperstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Stepnumberslider_Callback(hObject, eventdata, handles)
% hObject    handle to Stepnumberslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stepnumberslider as text
%        str2double(get(hObject,'String')) returns contents of Stepnumberslider as a double

global gl

set(handles.Stepnumbertext,'String',num2str(int32(get(handles.Stepnumberslider,'Value'))))

try
    handles=rmfield(handles,'maxsubpixel');
end
handles = loadimages(hObject,handles);
plotpanel(hObject,handles);

gl.handles=handles;



% --- Executes during object creation, after setting all properties.
function Stepnumberslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stepnumberslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Shotnumberslider_Callback(hObject, eventdata, handles)
% hObject    handle to Shotnumberslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of
%        slider

set(handles.Shotnumbertext,'String',num2str(int32(get(handles.Shotnumberslider,'Value'))))

plotpanel(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Shotnumberslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shotnumberslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Comment_Callback(hObject, eventdata, handles)
% hObject    handle to Comment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Comment as text
%        str2double(get(hObject,'String')) returns contents of Comment as a double


% --- Executes during object creation, after setting all properties.
function Comment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Comment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Stepnumbertext_Callback(hObject, eventdata, handles)
% hObject    handle to Stepnumbertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stepnumbertext as text
%        str2double(get(hObject,'String')) returns contents of Stepnumbertext as a double

value=str2num(get(hObject,'String'));
value=round(value);

if sum(value==[1:handles.scan.n_steps])
    set(handles.Stepnumberslider,'Value',value);
    handles = loadimages(hObject,handles);
    plotpanel(hObject,handles);
else
    error(['Input not in allowed range: 1 to ' handles.scan.n_steps])
end



% --- Executes during object creation, after setting all properties.
function Stepnumbertext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stepnumbertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Shotnumbertext_Callback(hObject, eventdata, handles)
% hObject    handle to Shotnumbertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Shotnumbertext as text
%        str2double(get(hObject,'String')) returns contents of Shotnumbertext as a double

value=str2num(get(hObject,'String'));
value=round(value);

if sum(value==[1:handles.param.n_shot])
    
%     try
%         handles=rmfield(handles,'maxsubpixel');
%     end

    set(handles.Shotnumberslider,'Value',value);
    plotpanel(hObject,handles);
else
    error(['Input not in allowed range: 1 to ' handles.param.n_shot])
end


% --- Executes during object creation, after setting all properties.
function Shotnumbertext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shotnumbertext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Maxcounts_Callback(hObject, eventdata, handles)
% hObject    handle to Maxcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

plotpanel(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Maxcounts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Maxcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Usebg.
function Usebg_Callback(hObject, eventdata, handles)
% hObject    handle to Usebg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Usebg

plotpanel(hObject,handles);


