function varargout = saw(varargin)
% SAW MATLAB code for saw.fig
%      SAW, by itself, creates a new SAW or raises the existing
%      singleton*.
%
%      H = SAW returns the handle to a new SAW or the handle to
%      the existing singleton*.
%
%      SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW.M with the given input arguments.
%
%      SAW('Property','Value',...) creates a new SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saw

% Last Modified by GUIDE v2.5 25-Jun-2021 15:52:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saw_OpeningFcn, ...
                   'gui_OutputFcn',  @saw_OutputFcn, ...
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


% --- Executes just before saw is made visible.
function saw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saw (see VARARGIN)

% Choose default command line output for saw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Untuk Import Data
opts = detectImportOptions('data.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('data.xlsx',opts);
%Untuk Import Data
opts = detectImportOptions('data.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('data.xlsx',opts);

%Untuk Menampilkan Data Excel di GUI
data = [data1 data2];
set(handles.uitable1,'data',data);

%Untuk Menentukan Kriteria Rumah Yang di Cari
opts = detectImportOptions('data.xlsx');
opts.SelectedVariableNames = (3:8);
x = readmatrix('data.xlsx',opts);
k=[0,1,1,1,1,1]; %Nilai Atribut, 0(cost), 1(benefit)
w=[0.30,0.20,0.23,0.10,0.07,0.10]; %Bobot

%Source Code Perhitungan Metode SAW
[m n]=size (x); 
R=zeros (m,n);
for j=1:n,
    if k(j)==1, 
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

%Source Code Untuk Menampilkan Hasil Perankingan Rumah Yang Dicari
Vtranspose=V.'; 
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('data.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('data.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(1:20,1);
%Untuk Menaruh Hasil Pada Tabel 
set(handles.uitable2, 'data', x2);
