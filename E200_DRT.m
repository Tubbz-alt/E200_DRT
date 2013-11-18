function varargout = E200_DRT(varargin)
% E200_DRT M-file for E200_DRT.fig
%      E200_DRT, by itself, creates a new E200_DRT or raises the existing
%      singleton*.
%
%      H = E200_DRT returns the handle to a new E200_DRT or the handle to
%      the existing singleton*.
%
%      E200_DRT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in E200_DRT.M with the given input arguments.
%
%      E200_DRT('Property','Value',...) creates a new E200_DRT or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before E200_DRT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to E200_DRT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help E200_DRT

% Last Modified by GUIDE v2.5 08-Nov-2013 17:31:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',	   mfilename, ...
				   'gui_Singleton',  gui_Singleton, ...
				   'gui_OpeningFcn', @E200_DRT_OpeningFcn, ...
				   'gui_OutputFcn',  @E200_DRT_OutputFcn, ...
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

% --- Executes just before E200_DRT is made visible.
function E200_DRT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to E200_DRT (see VARARGIN)

% Choose default command line output for E200_DRT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes E200_DRT wait for user response (see UIRESUME)
% uiwait(handles.figure1);

addpath(fullfile(pwd,'E200_data'));
addpath(genpath(fullfile(pwd,'aux_functions')));


% --- Outputs from this function are returned to the command line.
function varargout = E200_DRT_OutputFcn(hObject, eventdata, handles)
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

% global dirs;
% global gl;

% Extract most recent file location
prefix=get_remoteprefix();
searchpath = fullfile(prefix,'/nas/nas-li20-pm01/E200/');
dirs       = dir(searchpath);
% Convert to structure
dirs=struct2cell(dirs);
% Order by date
date=dirs(5,:);
date=cell2mat(date);
[ignore,ind]=sort(date);
dirs=dirs(:,ind);

% Get only directory names
dir_names=dirs(1,:);
% Look for directories with 4-digit
bool1=~cellfun(@isempty,regexp(dir_names,'\d{4}'));
% Directories only 4 characters long.
bool2=cellfun(@(x) length(x)==4,dir_names);
dirs=dirs(:,bool1 & bool2);
first=dirs{1,end};

searchpath = fullfile(searchpath,[first '/']);
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
[Filename,Pathname,FilterIndex]=uigetfile('*.mat','Open E200 scan_info file',defaultfile);
cd(curpath);

% Pathname='/nas/nas-li20-pm01/E200/2013/20130511/E200_11071/';
% Filename='E200_11071_scan_info.mat';

% Get the hostname of the computer.
[status,hostname]=unix('hostname');
hostname = strrep(hostname,sprintf('\n'),'');
isfs20=strcmp(hostname,'facet-srv20');

if isfs20
	loadfile=fullfile('/home/fphysics/joelfred',Pathname,Filename)
else
	loadfile=fullfile(Pathname,Filename)
end

% gl.loadfile=loadfile;
% loadfile = '/home/fphysics/joelfred/nas/nas-li20-pm01/E200/2013/20130428/E200_10836'

data=E200_load_data(loadfile);
% display(data.VersionInfo.Version);

switch data.raw.metadata.settype
	case 'scan'

		% n_steps=size(data.raw.metadata.scan_info,2)
		n_steps = data.raw.metadata.n_steps
		set(handles.Stepstaken,'String',n_steps);
		set(handles.Stepnumberslider,'Min',1);
		set(handles.Stepnumberslider,'Max',n_steps);
		set(handles.Stepnumberslider,'Value',1);
		set(handles.Stepnumberslider,'SliderStep',[1/(n_steps-1),2/(n_steps-1)]);
		set(handles.Stepnumberslider,'Enable','On');
		set(handles.Stepnumbertext,'String',1);
		set(handles.Stepnumbertext,'Enable','on');

		handles.scan.scan_info=data.raw.metadata.scan_info;
		handles.scan.n_steps=n_steps;
		
	case 'daq'
		
		set(handles.Stepstaken,'String','NOT A SCAN: NO STEPS!');
		
		set(handles.Stepnumberslider,'Enable','Off');
		set(handles.Stepnumbertext,'String','N/A');
	case 'none'
end

% All file initializations
if ~strcmp(data.raw.metadata.settype,'none')
	param=data.raw.metadata.param.dat{1};

	% Set strings
	Cams_str=fieldnames(data.raw.images);
	set(handles.Cams,'String',Cams_str);
	% set(handles.Cams,'Max',size(param.cams,1));

	% Save lookup table
	handles.CamsLookup.datatype=cell_construct('raw',1,size(Cams_str,1));
	handles.CamsLookup.name=Cams_str;
	
	set(handles.currentfile,'String',loadfile);
	set(handles.FileDate,'String',[param.year '-' param.month '-' param.day]);
	
	set(handles.Shotsperstep,'String',param.n_shot);

	set(handles.imageslider,'Min',1);
	set(handles.imageslider,'Max',1);
	set(handles.imageslider,'Value',1);
	set(handles.imageslider,'SliderStep',[1,10]);
	set(handles.imageslider,'Enable','off');

	set(handles.Maxcounts,'Min',1);
	set(handles.Maxcounts,'Max',1);
	set(handles.Maxcounts,'Value',1);
	set(handles.Maxcounts,'SliderStep',[1,10]);
	set(handles.Maxcounts,'Enable','off');

	set(handles.Mincounts,'Min',0);
	set(handles.Mincounts,'Max',1);
	set(handles.Mincounts,'Value',1);
	set(handles.Mincounts,'SliderStep',[1,10]);
	set(handles.Mincounts,'Enable','off');

	corr_str=fieldnames(data.raw.scalars);
	% First is special: just use index.
	corr_str=['As taken';corr_str];
	set(handles.Xcorrpopup,'String',corr_str);
	set(handles.Ycorrpopup,'String',corr_str);

	% Turn things off.
	cla(handles.fig1);
	
	set(handles.Comment,'String',param.comt_str);

 	handles.data=data;   
	
	% gl.param=param;
	% gl.Pathname=Pathname;
	% gl.dirs=dirs;
	% gl.cam_back=cam_back;
	% gl.handles=handles;
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

set(handles.imageslider,'Value',1);
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

% global gl

set(handles.Stepnumbertext,'String',num2str(int32(get(handles.Stepnumberslider,'Value'))))

try
	handles=rmfield(handles,'maxsubpixel');
end
handles = loadimages(hObject,handles);
plotpanel(hObject,handles);

% gl.handles=handles;



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


% --- Executes on slider movement.
function Maxcounts_Callback(hObject, eventdata, handles)
% hObject    handle to Maxcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

maxval=int32(get(handles.Maxcounts,'Value'));
minval=int32(get(handles.Mincounts,'Value'));

if maxval <= minval
	set(handles.Mincounts,'Value',maxval-1);
end

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

% --- Executes on button press in allsteps.
function allsteps_Callback(hObject, eventdata, handles)
% hObject    handle to allsteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allsteps


% --- Executes on button press in allshots.
function allshots_Callback(hObject, eventdata, handles)
% hObject    handle to allshots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allshots


% --- Executes on slider movement.
function imageslider_Callback(hObject, eventdata, handles)
% hObject    handle to imageslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

plotpanel(hObject,handles);


% --- Executes during object creation, after setting all properties.
function imageslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on selection change in Xcorrpopup.
function Xcorrpopup_Callback(hObject, eventdata, handles)
% hObject    handle to Xcorrpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Xcorrpopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Xcorrpopup


% --- Executes during object creation, after setting all properties.
function Xcorrpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xcorrpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Ycorrpopup.
function Ycorrpopup_Callback(hObject, eventdata, handles)
% hObject    handle to Ycorrpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Ycorrpopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ycorrpopup


% --- Executes during object creation, after setting all properties.
function Ycorrpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ycorrpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Corrplotbutton.
function Corrplotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Corrplotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global gl

% gl.hObject=hObject;

handles=corrplot(hObject,handles);

guidata(hObject,handles);


% --- Executes on slider movement.
function Mincounts_Callback(hObject, eventdata, handles)
% hObject    handle to Mincounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

maxval=int32(get(handles.Maxcounts,'Value'));
minval=int32(get(handles.Mincounts,'Value'));

if maxval <= minval
	set(handles.Maxcounts,'Value',minval+1);
end

plotpanel(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Mincounts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mincounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in yunits.
function yunits_Callback(hObject, eventdata, handles)
% hObject    handle to yunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns yunits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from yunits

contents = cellstr(get(hObject,'String'))
handles.yunits = contents{get(hObject,'Value')}
plotpanel(hObject,handles);

% --- Executes during object creation, after setting all properties.
function yunits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in xunits.
function xunits_Callback(hObject, eventdata, handles)
% hObject    handle to xunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xunits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xunits

contents = cellstr(get(hObject,'String'))
handles.xunits = contents{get(hObject,'Value')}
plotpanel(hObject,handles);

% --- Executes during object creation, after setting all properties.
function xunits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xunits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in analysisPopup.
function analysisPopup_Callback(hObject, eventdata, handles)
% hObject    handle to analysisPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns analysisPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from analysisPopup


% --- Executes during object creation, after setting all properties.
function analysisPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to analysisPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

addpath('analysis_panel_fxns');

analysis_panel_init(hObject,handles);
guidata(hObject, handles);

global ghandles
ghandles = handles;

display(hObject)

% rmpath('analysis_panel_fxns');

% --- Executes on button press in analysisButton.
function analysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to analysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

analysis_struct = analysis_info()

analysis_struct(get(handles.analysisPopup,'Value')).func(handles)
