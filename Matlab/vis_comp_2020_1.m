function varargout = vis_comp_2020_1(varargin)
% VIS_COMP_2020_1 MATLAB code for vis_comp_2020_1.fig
%      VIS_COMP_2020_1, by itself, creates a new VIS_COMP_2020_1 or raises the existing
%      singleton*.
%
%      H = VIS_COMP_2020_1 returns the handle to a new VIS_COMP_2020_1 or the handle to
%      the existing singleton*.
%
%      VIS_COMP_2020_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIS_COMP_2020_1.M with the given input arguments.
%
%      VIS_COMP_2020_1('Property','Value',...) creates a new VIS_COMP_2020_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vis_comp_2020_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vis_comp_2020_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vis_comp_2020_1

% Last Modified by GUIDE v2.5 20-Jun-2020 22:46:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vis_comp_2020_1_OpeningFcn, ...
                   'gui_OutputFcn',  @vis_comp_2020_1_OutputFcn, ...
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

end
% --- Executes just before vis_comp_2020_1 is made visible.
function vis_comp_2020_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vis_comp_2020_1 (see VARARGIN)

% Choose default command line output for vis_comp_2020_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vis_comp_2020_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = vis_comp_2020_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end
% --------------------------------------------------------------------
%Tag Ã© como vai aparecer no codigo
function Iniciar_Callback(hObject, eventdata, handles)
% hObject    handle to Iniciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end
% --------------------------------------------------------------------
function Converter_Callback(hObject, eventdata, handles)
% hObject    handle to Converter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end
% --------------------------------------------------------------------
function Abrir_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [impath, user_canceled] = imgetfile;
    
    if user_canceled
        msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
        return;
    end
    
    im=imread(impath);
    axes(handles.axes1);
    imshow(im);
    
end

% --------------------------------------------------------------------
function Salvar_Callback(hObject, eventdata, handles)
% hObject    handle to Salvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    im_out2 = getimage(handles.axes2);%tomar cuidado com o axes que contera a imagem

    if (~isempty(im_out2))

        [imname, impath] = uiputfile('*.bmp');
        nome = strcat(impath,imname);
        imwrite(im_out2,nome,'bmp');

    end
end
% --------------------------------------------------------------------
function Sair_Callback(hObject, eventdata, handles)
% hObject    handle to Sair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close all;
end

% --------------------------------------------------------------------
function Gray_Callback(hObject, eventdata, handles)
% hObject    handle to Gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   im = getimage(handles.axes1);
   [~, ~, dim] = size(im);
   if dim == 3
        im2 = (0.2989*im(:,:,1) + 0.5870*im(:,:,2) + 0.1140*im(:,:,3));
   else
        im2 = im;
   end
   axes(handles.axes2);
   imshow(im2);
end   
% --------------------------------------------------------------------
function Binario_Callback(hObject, eventdata, handles)
% hObject    handle to Binario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   im = getimage(handles.axes1);
   lim = round(get(handles.Limiar, 'Value'));
   im = double(im);
   [~,~,dim] = size(im);
   if dim == 3
       im = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3;
   end
   im = uint8(im);
   bin_im = (im > lim)*1;
   axes(handles.axes2);
   imshow(bin_im);
end
% --- Executes on slider movement.

function Binario_Slider(lim_value, handles)

   im = getimage(handles.axes1);
   im = double(im);
   [~,~,dim] = size(im);
   if dim == 3
       im = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3;
   end
   im = uint8(im);
   bin_im = (im > lim_value)*1;
   axes(handles.axes2);
   imshow(bin_im);
end

function Limiar_Callback(hObject, eventdata, handles)
% hObject    handle to Limiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    lim_Value = get(hObject, 'Value');
    set(handles.text10,'String',num2str(round(lim_Value)));
    Binario_Slider(lim_Value, handles);
end 
    
% --- Executes during object creation, after setting all properties.
function Limiar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Limiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
end

function Negativo_Callback(hObject, eventdata, handles)
% hObject    handle to Negativo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte, 3) == 3
        aux = zeros(size(fonte));
        aux(:,:,1) = 255 - fonte(:,:,1);
        aux(:,:,2) = 255 - fonte(:,:,2);
        aux(:,:,3) = 255 - fonte(:,:,3);
    else
        aux = 255 - fonte;
    end

    aux = uint8(aux);
    axes(handles.axes2);
    imshow(aux);
end


% --------------------------------------------------------------------

function [bin_im] = Binario_Cam(handles, IMAGEM)
   
   lim_Value = round(get(handles.Limiar, 'Value'));
   im = IMAGEM;
   im = double(im);
   [~,~,dim] = size(im);
   if dim == 3
       im = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3;
   end
   im = uint8(im);
   bin_im = (im > lim_Value)*1;
end
   

function Acessar_WEBCAM_Callback(hObject, eventdata, handles)
% hObject    handle to Acessar_WEBCAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    

end
% --------------------------------------------------------------------

% --------------------------------------------------------------------
%Funcao que cria o objeto que acessa a webcam, comeca a fazer a captura e a
%mostrar tanto a captura quanto o processamento de limiarizaÃ§Ã£o feito
function Comecar_Callback(hObject, eventdata, handles)
% hObject    handle to Comecar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.output = hObject;
    handles.cam = webcam(1);
    global continuar;
    continuar = 1;
    while continuar
        cam = handles.cam;
        data = snapshot(cam);
        axes(handles.axes1)
        imshow(data)
        drawnow;
        axes(handles.axes2)
        bin_im = Binario_Cam(handles, data);
        imshow(bin_im)
        drawnow;
    end
    guidata(hObject, handles);

end

% --------------------------------------------------------------------
%Funcao que para de fazer a captura e para de fazer a amostra das imagens
%da webcam
function Parar_Callback(hObject, eventdata, handles)
% hObject    handle to Parar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global continuar;
    continuar = 0;
    guidata(hObject, handles);
end

% --------------------------------------------------------------------
%Funcao que deleta o objeto webcam 
%da webcam
function Deletar_Callback(hObject, eventdata, handles)
% hObject    handle to Deletar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cam = handles.cam;
    delete (cam);
    clear cam;
    guidata(hObject, handles);
end


% --------------------------------------------------------------------
function Operacoes_Callback(hObject, eventdata, handles)
% hObject    handle to Operacoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function Aritmeticas_Callback(hObject, eventdata, handles)
% hObject    handle to Aritmeticas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Logicas_Callback(hObject, eventdata, handles)
% hObject    handle to Logicas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Logica_OR_Callback(hObject, eventdata, handles)
% hObject    handle to Logica_OR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3)
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(size(im1)) > 2) || (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
        [impath3, ~] = imgetfile;
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
            return;
    end
    
    im_or = or(im1, im3);
    im_or = uint8(255*im_or);
    axes(handles.axes2);
    imshow(im_or);
    
    
    
end

% --------------------------------------------------------------------
function Logica_AND_Callback(hObject, eventdata, handles)
% hObject    handle to Logica_AND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3)
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(size(im1)) > 2) || (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
        [impath3, ~] = imgetfile;
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
            return;
    end
    
    im_and = and(im1, im3);
    im_and = uint8(255*im_and);
    axes(handles.axes2);
    imshow(im_and);


end

% --------------------------------------------------------------------
function Logica_NOT_Callback(hObject, eventdata, handles)
% hObject    handle to Logica_NOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    if (length(size(im1)) > 2)
        msgbox(sprintf('Mensagem deve ser binaria'),'error','error');
            return;
    end
    
    im_not = not(im1);
    im_not = uint8(255*im_not);
    axes(handles.axes2);
    imshow(im_not);

end

% --------------------------------------------------------------------
function Logica_XOR_Callback(hObject, eventdata, handles)
% hObject    handle to Logica_XOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3)
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(size(im1)) > 2) || (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
        [impath3, ~] = imgetfile;
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
            return;
    end
    
    im_Xor = xor(im1, im3);
    im_Xor = uint8(255*im_Xor);
    axes(handles.axes2);
    imshow(im_Xor);


end

% --------------------------------------------------------------------
function Soma_Callback(hObject, eventdata, handles)
% hObject    handle to Soma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Subtracao_Callback(hObject, eventdata, handles)
% hObject    handle to Subtracao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Multiplicacao_Callback(hObject, eventdata, handles)
% hObject    handle to Multiplicacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Divisao_Callback(hObject, eventdata, handles)
% hObject    handle to Divisao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Divisao_Escalar_Callback(hObject, eventdata, handles)
% hObject    handle to Divisao_Escalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im1 = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(im1)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    
    prompt = {'Entre com o valor do escalar'};
    dlgtitle = 'ENTRADA ESCALAR';
    dims = 1;
    definput = {'1'};
    escalar = (inputdlg(prompt,dlgtitle,dims,definput));
    escalar = (str2double(escalar{1}));
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    

    %Faz a DivisÃ£o entre a Imagem e o Escalar
    if length(size(im1)) == 3
        im_div = im1;
        R = double(im1(:,:,1)) ./ escalar;
        G = double(im1(:,:,2)) ./ escalar;
        B = double(im1(:,:,3)) ./ escalar;
        im_div(:,:,1) = uint8(R); 
        im_div(:,:,2) = uint8(G);
        im_div(:,:,3) = uint8(B);
    else
        im_div = double(im1);
        im_div = im_div ./ escalar;
        im_div = uint8(im_div);
    end
    
    
    axes(handles.axes2);
    imshow(im_div);


end

% --------------------------------------------------------------------
function Divisao_Imagem_Callback(hObject, eventdata, handles)
% hObject    handle to Divisao_Imagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1) 
        msgbox(sprintf('Abra a Primeira Imagem'));
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3) 
        msgbox(sprintf('Abra a Segunda Imagem'));
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
            return;
    end
    %Faz as DivisÃµes entre canais entre as imagens
    if length(size(im1)) == 3
        im_div = uint8(zeros(size(im1)));
        R = double(im1(:,:,1)) ./ double(im3(:,:,1));
        G = double(im1(:,:,2)) ./ double(im3(:,:,2));
        B = double(im1(:,:,3)) ./ double(im3(:,:,3));
        R = uint8(255*(R - min(R(:)))./(max(R(:)) - min(R(:))));
        G = uint8(255*(G - min(G(:)))./(max(G(:)) - min(G(:))));
        B = uint8(255*(B - min(B(:)))./(max(B(:)) - min(B(:))));
        im_div(:,:,1) = R;
        im_div(:,:,2) = G;
        im_div(:,:,3) = B;
        clear R G B;
    else
        im_div = uint8(zeros(size(im1)));
        aux = double(im1(:,:)) ./ double(im3(:,:));
        aux = uint8(255*(aux - min(aux(:)))./(max(aux(:)) - min(aux(:))));
        im_div = aux;
        clear aux;
    end
    
    
    axes(handles.axes2);
    imshow(im_div);
end

% --------------------------------------------------------------------
function Multiplicacao_Escalar_Callback(hObject, eventdata, handles)
% hObject    handle to Multiplicacao_Escalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    im1 = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(im1)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    
    prompt = {'Entre com o valor do escalar'};
    dlgtitle = 'ENTRADA ESCALAR';
    dims = 1;
    definput = {'1'};
    escalar = (inputdlg(prompt,dlgtitle,dims,definput));
    escalar = (str2double(escalar{1}));
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    
    %Faz o produto entre o Escalar e a Imagem
    if length(size(im1)) == 3
        im_prod = im1;
        R = double(im1(:,:,1)) .* escalar;
        G = double(im1(:,:,2)) .* escalar;
        B = double(im1(:,:,3)) .* escalar;
        im_prod(:,:,1) = R; 
        im_prod(:,:,2) = G;
        im_prod(:,:,3) = B;
    else
        im_prod = double(im1);
        im_prod = im_prod .* escalar;
        im_prod = uint8(im_prod);
    end
    
    
    axes(handles.axes2);
    imshow(im_prod);
end

% --------------------------------------------------------------------
function Multiplicacao_Imagem_Callback(hObject, eventdata, handles)
% hObject    handle to Multiplicacao_Imagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1) 
        msgbox(sprintf('Abra a Primeira Imagem'));
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3) 
        msgbox(sprintf('Abra a Segunda Imagem'));
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
            return;
    end
    %Faz o produto entre os canais das Imagens
    if length(size(im1)) == 3
        im_prod = uint8(zeros(size(im1)));
        R = double(im1(:,:,1)) .* double(im3(:,:,1));
        G = double(im1(:,:,2)) .* double(im3(:,:,2));
        B = double(im1(:,:,3)) .* double(im3(:,:,3));
        R = uint8(255*(R - min(R(:)))./(max(R(:)) - min(R(:))));
        G = uint8(255*(G - min(G(:)))./(max(G(:)) - min(G(:))));
        B = uint8(255*(B - min(B(:)))./(max(B(:)) - min(B(:))));
        im_prod(:,:,1) = R;
        im_prod(:,:,2) = G;
        im_prod(:,:,3) = B;
        clear R G B;
    else
        im_prod = uint8(zeros(size(im1)));
        aux = double(im1(:,:)) .* double(im3(:,:));
        aux = uint8(255*(aux - min(aux(:)))./(max(aux(:)) - min(aux(:))));
        im_prod = aux;
        clear aux;
    end
    
    
    axes(handles.axes2);
    imshow(im_prod);
end

% --------------------------------------------------------------------
function Subtracao_Escalar_Callback(hObject, eventdata, handles)
% hObject    handle to Subtracao_Escalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im1 = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(im1)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    
    prompt = {'Entre com o valor do escalar'};
    dlgtitle = 'ENTRADA ESCALAR';
    dims = 1;
    definput = {'1'};
    escalar = (inputdlg(prompt,dlgtitle,dims,definput));
    escalar = uint8(str2double(escalar{1}));
    
    [linhas, colunas, ~] = size(im1);
    %Faz a soma entre canais entre as imagens
    if length(size(im1)) == 3
        im_sub = im1;
        im_sub(:,:,1) = im_sub(:,:,1) - escalar*uint8(ones(linhas, colunas));
        im_sub(:,:,2) = im_sub(:,:,2) - escalar*uint8(ones(linhas, colunas));
        im_sub(:,:,3) = im_sub(:,:,3) - escalar*uint8(ones(linhas, colunas));
    else
        im_sub = im1;
        im_sub = im_sub - escalar*uint8(ones(linhas, colunas));
        clear aux;
    end
    
    axes(handles.axes2);
    imshow(im_sub);

end

% --------------------------------------------------------------------
%Efetua operaÃ§Ã£o de SubtraÃ§Ã£o entre imagens Coloridas ou em Tons de Cinza 
%(axes1 e axes3) e mostra o resultado em axes2
function Subtracao_Imagem_Callback(hObject, eventdata, handles)
% hObject    handle to Subtracao_Imagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3)
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
        [impath3, ~] = imgetfile;
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
            return;
    end
    %Faz as soma entre canais entre as imagens
    if length(size(im1)) == 3
        im_sub = uint8(zeros(size(im1)));
        R = double(im1(:,:,1)) - double(im3(:,:,1));
        G = double(im1(:,:,2)) - double(im3(:,:,2));
        B = double(im1(:,:,3)) - double(im3(:,:,3));
        im_sub(:,:,1) = uint8(R);
        im_sub(:,:,2) = uint8(G);
        im_sub(:,:,3) = uint8(B);
        clear R G B;
    else
        
        aux = double(im1(:,:)) - double(im3(:,:));
        im_sub = uint8(aux);
        clear aux;
    end
    
    
    axes(handles.axes2);
    imshow(im_sub);
    
end

% --------------------------------------------------------------------
%Efetua operaÃ§Ã£o de Soma Escalar em uma Imagem Colorida ou em Tons de Cinza 
%(axes1 e axes3) e mostra o resultado em axes2
function Soma_Escalar_Callback(hObject, eventdata, handles)
% hObject    handle to Soma_Escalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Operacao feita na imagem armazenada no axes1 e joga em axes 2 (Resultado)
    
    im1 = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(im1)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    
    prompt = {'Entre com o valor do escalar'};
    dlgtitle = 'ENTRADA ESCALAR';
    dims = 1;
    definput = {'1'};
    escalar = (inputdlg(prompt,dlgtitle,dims,definput));
    escalar = uint8(str2double(escalar{1}));
    
    [linhas, colunas, ~] = size(im1);
    %Faz a soma entre canais entre as imagens
    if length(size(im1)) == 3
        im_soma = im1;
        im_soma(:,:,1) = im_soma(:,:,1) + escalar*uint8(ones(linhas, colunas));
        im_soma(:,:,2) = im_soma(:,:,2) + escalar*uint8(ones(linhas, colunas));
        im_soma(:,:,3) = im_soma(:,:,3) + escalar*uint8(ones(linhas, colunas));
    else
        im_soma = im1;
        im_soma = im_soma + escalar*uint8(ones(linhas, colunas));
        clear aux;
    end
    
    
    axes(handles.axes2);
    imshow(im_soma);
        
   
end

% --------------------------------------------------------------------
%Efetua operaÃ§Ã£o de Soma entre imagens Coloridas ou em Tons de Cinza 
%(axes1 e axes3) e mostra o resultado em axes2
function Soma_Imagem_Callback(hObject, eventdata, handles)
% hObject    handle to Soma_Imagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Operacao feita entre as imagens armazenadas em: axes1 e axes 3 
%mostrando o resultado em axes2(Resultado)


    im3 = getimage(handles.axes3);
    im1 = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    %Verifica se tem imagem em axis3
    if isempty(im3)
        [impath3, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
    end
    %verifica se as imagens tem as mesmas dimensÃµes e os mesmos tamanhos
    if (length(im1) ~= length(im3)) || (sum(size(im1) ~= size(im3)))
        msgbox(sprintf('Imagens de Tamanhos Distintos'),'error','error');
        [impath3, ~] = imgetfile;
        im3 = imread(impath3);
        axes(handles.axes3);
        imshow(im3);
            return;
    end
    %Faz as soma entre canais entre as imagens
    if length(size(im1)) == 3
        im_soma = uint8(zeros(size(im1)));
        R = double(im1(:,:,1)) + double(im3(:,:,1));
        G = double(im1(:,:,2)) + double(im3(:,:,2));
        B = double(im1(:,:,3)) + double(im3(:,:,3));
        im_soma(:,:,1) = uint8(R);
        im_soma(:,:,2) = uint8(G);
        im_soma(:,:,3) = uint8(B);
        clear R G B;
    else
        
        aux = double(im1(:,:)) + double(im3(:,:));
        im_soma = uint8(aux);
        clear aux;
    end
    
    
    axes(handles.axes2);
    imshow(im_soma);
end


% --- Executes on button press in B1_Prin_Aux.
%Botao que leva a Imagem Principal para a auxiliar, axes 3
%Se nÃ£o tiver ele pede para carregar uma imagem e executa a atribuicao
%original
function B1_Prin_Aux_Callback(~, ~, handles)
% hObject    handle to B1_Prin_Aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    im1 = getimage(handles.axes1);
    if isempty(im1)
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im1 = imread(impath1);
        axes(handles.axes1);
        imshow(im1);
    end
    
    axes(handles.axes3);
    imshow(im1);
    
end

% --- Executes on button press in B2_Res_to_Aux.
%Botao que leva a imagem processada para o local auxiliar, axes3
%Se nÃ£o tiver ele pede para carregar uma imagem e executa a atribuicao
%original
function B2_Res_to_Aux_Callback(~, ~, handles)
% hObject    handle to B2_Res_to_Aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    im2 = getimage(handles.axes2);
    if isempty(im2)
        [impath2, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im2 = imread(impath2);
        axes(handles.axes2);
        imshow(im2);
    end
    
    axes(handles.axes3);
    imshow(im2);

end


% --- Executes on button press in B3_Res_to_IMP.
%Botao que carrega a imagem processada o axes1, para ser tomada como imagem
%principal
%Se nÃ£o tiver ele pede para carregar uma imagem e executa a atribuicao
%original
function B3_Res_to_IMP_Callback(~, ~, handles)
% hObject    handle to B3_Res_to_IMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    im2 = getimage(handles.axes2);
    if isempty(im2)
        [impath2, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        im2 = imread(impath2);
        axes(handles.axes2);
        imshow(im2);
    end
    
    axes(handles.axes1);
    imshow(im2);

end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Escalonamento_Callback(hObject, eventdata, handles)
% hObject    handle to Escalonamento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    

    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    auxiliar = zeros(size(fonte));
    
    prompt = {'scala_x:', 'scala_y:', 'centro_x:', 'centro_y:'};
    dlgtitle = 'ESCALONAMENTO';
    dims = [1 35];
    %default identidade e ve
    definput = {'1', '1', '0', '0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    s = zeros(2,1); % Escala de zoom
    centro_aux = zeros(2,1);
    s(1) = str2num(answer{1});
    s(2) = str2num(answer{2});
    centro_aux(1) = str2num(answer{3});
    centro_aux(2) = str2num(answer{4});
    
    [linhas, colunas, canais] = size(auxiliar);
    
    %teste para saber se o centro a ser considerado nao for o padrao
    if sum(centro_aux) == 0
        centro = round([linhas/2 colunas/2]');
    else
        centro = centro_aux;
    end
    
    
    [xx, yy] = meshgrid(1:linhas, 1:colunas);
    x_y = [xx(:) yy(:)]';
    x_y_2 = x_y - centro;
    x_y_2 = [x_y_2; ones(1, length(xx(:)))]';
    centro = [centro; 0];
    T = [s(1) 0 0;0 s(2) 0; 0 0 1];
    real_u_v = T\x_y_2' + centro;
    clear x_y_2;
    real_u_v = floor(real_u_v);
    n = size(real_u_v,2);
    
    if canais > 1
        for i = 1:n
           if colunas > linhas
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y(1,i),x_y(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           else
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y(1,i),x_y(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           end
        end
    else
        for i = 1:n
           if colunas > linhas
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y(1,i),x_y(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           else             
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y(1,i),x_y(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           end
        end
   end
    
    
    axes(handles.axes2);
    imshow(uint8(auxiliar));

end

% --------------------------------------------------------------------
function Translacao_Callback(hObject, eventdata, handles)
% hObject    handle to Translacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fonte = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    auxiliar = zeros(size(fonte));
    
    prompt = {'dx:','dy:'};
    dlgtitle = 'Translacao';
    dims = [1 35];
    definput = {'20','20'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    dx = str2num(answer{1});
    dy = str2num(answer{2});
    
    [linhas, colunas, canais] = size(auxiliar);
    
    [xx, yy] = meshgrid(1:linhas, 1:colunas);
    x_y_2 = [xx(:) yy(:) ones(length(xx(:)), 1)];
    T = [1 0 dx; 0 1 dy; 0 0 1];
    real_u_v = T\x_y_2';
    x_y_2 = x_y_2';
    real_u_v = floor(real_u_v);
    n = size(real_u_v,2);
    
    if canais > 1
        for i = 1:n
           if colunas > linhas
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y_2(1,i),x_y_2(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           else
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y_2(1,i),x_y_2(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           end
        end
    else
        for i = 1:n
           if colunas > linhas
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y_2(1,i),x_y_2(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           else             
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y_2(1,i),x_y_2(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           end
        end
    end
    
    
    axes(handles.axes2);
    imshow(uint8(auxiliar));
    
end

% --------------------------------------------------------------------
function Rotacao_Callback(hObject, eventdata, handles)
% hObject    handle to Rotacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    auxiliar = zeros(size(fonte));
    
    prompt = {'theta (graus):', 'centro_x:', 'centro_y:'};
    dlgtitle = 'ROTACAO';
    dims = [1 35];
    definput = {'45','0', '0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    theta = str2num(answer{1});
    centro_aux = zeros(2,1);
    centro_aux(1) = str2num(answer{2});
    centro_aux(2) = str2num(answer{3});
    
    [linhas, colunas, canais] = size(auxiliar);
    
    
    if sum(centro_aux) == 0
        centro = round([linhas/2 colunas/2]');
    else
        centro = centro_aux;
    end
    
    
    [xx, yy] = meshgrid(1:linhas, 1:colunas);
    x_y = [xx(:) yy(:)]';
    x_y_2 = x_y - centro;
    x_y_2 = [x_y_2; ones(1, length(xx(:)))]';
    centro = [centro; 0];
    T = [cosd(-theta) sind(-theta) 0; -sind(-theta) cosd(-theta) 0; 0 0 1];
    real_u_v = T\x_y_2' + centro;
    clear x_y_2;
    real_u_v = floor(real_u_v);
    n = size(real_u_v,2);
    
    if canais > 1
        for i = 1:n
           if colunas > linhas
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y(1,i),x_y(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           else
               for j = 1:canais
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y(1,i),x_y(2,i), j) = fonte(real_u_v(1,i),real_u_v(2,i), j);
                   else
                       continue;
                   end
               end
           end
        end
    else
        for i = 1:n
           if colunas > linhas
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,1), real_u_v(2,i) <= size(auxiliar,2)))
                      auxiliar(x_y(1,i),x_y(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           else             
                   if and(and(real_u_v(1,i) > 0, real_u_v(2,i) > 0), and(real_u_v(1,i) <= size(auxiliar,2), real_u_v(2,i) <= size(auxiliar,1)))
                      auxiliar(x_y(1,i),x_y(2,i)) = fonte(real_u_v(1,i),real_u_v(2,i));
                   else
                       continue;
                   end
           end
        end
   end
    
    
    axes(handles.axes2);
    imshow(uint8(auxiliar));

end


% --------------------------------------------------------------------

%rotina que calcula a convolução 2d resultando no shape original da imagem
%Sera usada por cada metodo de deteccao de borda distinto e nas filtragens
%espaciais;
%Para ativar o efeito da limiarizacao, basta jogar a imagem resultado para
%o axis principal e comecar a rolar a barra seletora de limiar 
function  C  = conv2d_isr(A, B)

    A = double(A);
    %matriz que recebera a operação
    C = zeros(size(A));

    % vetorização e para e inversão dos eixos da mascara para a operação de con
    %volucao
    kernel_vetorizado = reshape(flip(flip(B,1),2)' ,[] , 1);

    % preenchendo com zeros a matriz para operação da convolução e fazendo a
    % operação em cima da matriz orignal uma 
    Imagem_zeros = padarray(A, [floor(size(B,1)/2) floor(size(B,2)/2)]);


    for i = 1:size(A,1)
        for j = 1:size(A,2)
            imagem_vet_zeros = reshape(Imagem_zeros(i: i + size(B,1) - 1, j:j + size(B,2) - 1)',1,[]);
            C(i,j) = imagem_vet_zeros*kernel_vetorizado;
        end
    end
end


function Bordas_Callback(hObject, eventdata, handles)
% hObject    handle to Bordas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------





function Derivativo_1_Callback(hObject, eventdata, handles)
% hObject    handle to Derivativo_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    g_x = [1 -1];
    g_y = g_x';
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    M_x = conv2d_isr(fonte, g_x);
    M_y = conv2d_isr(fonte, g_y);
    Grad_fonte = sqrt(M_x.^2 + M_y.^2);
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(Grad_fonte));
    else  
        %Valor padrao, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(Grad_fonte > 127)));
    end
    
end

% --------------------------------------------------------------------
function Derivativo_2_Callback(hObject, eventdata, handles)
% hObject    handle to Derivativo_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end

    g_x = [1 0 -1];
    g_y = g_x';
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    M_x = conv2d_isr(fonte, g_x);
    M_y = conv2d_isr(fonte, g_y);
    Grad_fonte = sqrt(M_x.^2 + M_y.^2);
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(Grad_fonte));
    else  
        %Valor padrao, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(Grad_fonte > 127)));
    end
end

% --------------------------------------------------------------------
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end

    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    M_x = conv2d_isr(fonte, sobel_x);
    M_y = conv2d_isr(fonte, sobel_y);
    Grad_fonte = sqrt(M_x.^2 + M_y.^2);
    Fase_fonte = atan2(M_y, M_x);
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(Grad_fonte));
    else  
        %Valor padrao, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(Grad_fonte > 127)));
    end

end

% --------------------------------------------------------------------
function Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    prewitt_x = (1/3)*[ 1  0 -1; 1 0 -1; 1 0 -1];
    prewitt_y = (1/3)*[-1 -1 -1; 0 0  0; 1 1  1];
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    M_x = conv2d_isr(fonte, prewitt_x);
    M_y = conv2d_isr(fonte, prewitt_y);
    Grad_fonte = sqrt(M_x.^2 + M_y.^2);
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(Grad_fonte));
    else  
        %Valor padrao, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(Grad_fonte > 127)));
    end
end


% --------------------------------------------------------------------
function Kirsch_Callback(hObject, eventdata, handles)
% hObject    handle to Kirsch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    K0 = [-3 -3 5; -3 0 5; -3 -3 5];
    K1 = [-3 5 5; -3 0 5; -3 -3 -3];
    K2 = [5 5 5; -3 0 -3; -3 -3 -3];
    K3 = [5 5 -3; 5 0 -3; -3 -3 -3];
    K4 = [5 -3 -3; 5 0 -3; 5 -3 -3];
    K5 = [-3 -3 -3; 5 0 -3; 5 5 -3];
    K6 = [-3 -3 -3; -3 0 -3; 5 5 5];
    K7 = [-3 -3 -3; -3 0 5; -3 5 5];
    
    kirs_res = zeros(size(fonte));
    M0 = conv2d_isr(fonte, K0);
    M1 = conv2d_isr(fonte, K1);
    M2 = conv2d_isr(fonte, K2);
    M3 = conv2d_isr(fonte, K3);
    M4 = conv2d_isr(fonte, K4);
    M5 = conv2d_isr(fonte, K5);
    M6 = conv2d_isr(fonte, K6);
    M7 = conv2d_isr(fonte, K7);
    
    %Pegando o maximo -> Rpz que negocio sensacional
    kirs_res = max(kirs_res, M0);
    kirs_res = max(kirs_res, M1);
    kirs_res = max(kirs_res, M2);
    kirs_res = max(kirs_res, M3);
    kirs_res = max(kirs_res, M4);
    kirs_res = max(kirs_res, M5);
    kirs_res = max(kirs_res, M6);
    kirs_res = max(kirs_res, M7);
    
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(kirs_res));
    else  
        %Valor padrao, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(kirs_res > 127)));
    end
    
end


% --------------------------------------------------------------------
function Laplaciano_Callback(hObject, eventdata, handles)
% hObject    handle to Laplaciano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Deseja ver a Imagem Limiarizada: 1(sim) 0(nao)'};
    dlgtitle = 'LIMIARIZACAO';
    dims = [1 35];
    definput = {'0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    escolha = str2num(answer{1});
    
    if isempty(escolha)
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end
    
    
    if and(escolha ~= 1, escolha ~= 0)   
        msgbox(sprintf('Opcao invalida. Entre com 1 ou 0!!!'),'error','error');
        return
    end

    prompt = {'Mascara (3, 5, 9):'};
    dlgtitle = 'Laplaciano';
    dims = [1 35];
    definput = {'3'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    tipo_lap = str2num(answer{1});
    
    if isempty(tipo_lap)
        msgbox(sprintf('Opcao invalida. Entre com 3, 5 ou 9!!!'),'error','error');
        return
    end
    
    
    if and(and(tipo_lap ~= 3, tipo_lap ~= 5), tipo_lap ~= 9)   
        msgbox(sprintf('Opcao invalida. Entre com 3, 5 ou 9!!!'),'error','error');
        return
    end
    
    
    if tipo_lap == 3
        mascara = [0 -1 0; 
                   -1 4 -1;
                   0 -1 0];
    else if tipo_lap == 5
            mascara  = [-1 -1 -1 -1 -1;
                        -1 -1 -1 -1 -1;
                        -1 -1 24 -1 -1;
                        -1 -1 -1 -1 -1;
                        -1 -1 -1 -1 -1];
        else if tipo_lap == 9
                mascara = [-1 -1 -1 -1 -1 -1 -1 -1 -1;
                           -1 -1 -1 -1 -1 -1 -1 -1 -1;
                           -1 -1 -1 -1 -1 -1 -1 -1 -1;
                           -1 -1 -1  8  8  8 -1 -1 -1;
                           -1 -1 -1  8  8  8 -1 -1 -1;
                           -1 -1 -1  8  8  8 -1 -1 -1;
                           -1 -1 -1 -1 -1 -1 -1 -1 -1;
                           -1 -1 -1 -1 -1 -1 -1 -1 -1;
                           -1 -1 -1 -1 -1 -1 -1 -1 -1];
            else 
                msgbox(sprintf('Opção Inválida: 3, 5 ou 9!\nA operacao nao pode ser concluida'),'error','error');
                return;
            end
        end
    end
    
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pÃ´de ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    Laplaciano = conv2d_isr(fonte, mascara);
    %Laplaciano = Laplaciano - min(Laplaciano(:));
    %Laplaciano = 255*(Laplaciano/max(Laplaciano(:)));
    
    axes(handles.axes2);
    if escolha == 0
        imshow(uint8(Laplaciano));
    else  
        %Valor padrao 127, para alterar processa a imagem padrão sem limiar e 
        %brinca com o slider para visualizar o resultado para diferentes es
        %colhas de limiares
        imshow(uint8(255*(Laplaciano > 127)));
    end
end

% --------------------------------------------------------------------
% Funcoes uteis para o detector Canny

function [H] = kernel_gaussiano(tam, mu, sigma)
    tam = fix(tam/2); %divisao inteira
    [xx, yy] = meshgrid(-tam:tam, -tam:tam);
    H = exp(-((xx - mu).^2 + (yy - mu).^2)/(2*sigma^2))*(1/(2*pi*sigma^2));
end

function [M_x, M_y, Grad, Fase] = sobel_canny(fonte)
    %E assumido que a fonte sera passada como double
    
    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    M_x = conv2d_isr(fonte, sobel_x);
    M_y = conv2d_isr(fonte, sobel_y);
    Grad = sqrt(M_x.^2 + M_y.^2);
    Fase = atan2d(M_y, M_x);
    
end

function [Z] = non_max_sup(fonte_pre, Fase)
    
    Z = zeros(size(fonte_pre));
    [linha, coluna] = size(fonte_pre);
    Fase(Fase < 0) = Fase(Fase < 0) + 180;
    
    for i = 2:linha - 1
        for j = 2:coluna - 1
            q = 255;
            r = 255;
 
            if or(0 <= Fase(i,j) < 22.5, 157.5 <= Fase(i,j) <= 180)
                q = fonte_pre(i, j+1);
                r = fonte_pre(i, j-1);
                else if (22.5 <= Fase(i,j) < 67.5)
                    q = fonte_pre(i+1, j-1);
                    r = fonte_pre(i-1, j+1); 
                    else if (67.5 <= Fase(i,j) < 112.5)
                        q = fonte_pre(i+1, j);
                        r = fonte_pre(i-1, j);
                        else if (112.5 <= Fase(i,j) < 157.5 )
                             q = fonte_pre(i-1, j-1);
                             r = fonte_pre(i+1, j+1);
                            end
                        end
                    end
            end
            if and(fonte_pre(i,j) >= q, fonte_pre(i,j) >= r)
                Z(i,j) = fonte_pre(i,j);
            end
        end
    end


end


function [resultado, fraco, forte] = limiar_aux_canny(fonte_pro, fraco, forte, limiar_baixo_taxa, limiar_alto_taxa) 
    limiar_alto = max(fonte_pro(:))*limiar_alto_taxa;
    limiar_baixo = limiar_alto*limiar_baixo_taxa;
%     [x_forte, y_forte, ~] = find(fonte_pro >= limiar_alto);
%     ind_forte = sub2ind(size(fonte_pro),x_forte,y_forte);
%     [x_fraco, y_fraco, ~] = find(and(fonte_pro <= limiar_alto, fonte_pro>= limiar_baixo));
%     ind_fraco = sub2ind(size(fonte_pro),x_fraco,y_fraco);
    resultado = zeros(size(fonte_pro));
    resultado(fonte_pro >= limiar_alto) = forte;
    resultado(and(fonte_pro <= limiar_alto, fonte_pro>= limiar_baixo)) = fraco;
%     for ind = 1:length(ind_forte)
%         resultado(ind_forte(ind)) = forte;
%     end
%     for ind = 1:length(ind_fraco)
%         resultado(ind_fraco(ind)) = fraco;
%     end
    
    
end

function [resultado] = hysteresis(img, fraco, forte)
    resultado = img;
    [M, N, ~] = size(resultado);
    for i = 2:M-1
        for j = 2:N-1
            if resultado(i,j) == fraco
                if ((resultado(i+1, j-1) == forte) || (resultado(i+1, j-0) == forte) ||...
                   (resultado(i+1, j+1) == forte) || (resultado(i+0, j-1) == forte) ||...
                   (resultado(i+0, j+1) == forte) || (resultado(i-1, j-1) == forte) ||...
                   (resultado(i-1, j-0) == forte) || (resultado(i-1, j+1) == forte))
                    resultado(i,j) = forte;
                else
                    resultado(i,j) = fraco;
                end
            end
        end
    end
    
    
end


function Canny_Callback(hObject, eventdata, handles)
% hObject    handle to Canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end 
    
    prompt = {'Limiar_baixo:','Limiar_alto:', 'Fraco: ', 'Forte: ',... 
              'Tamanho_Mascara: ','Mu: ', 'Sigma: '};
    dlgtitle = 'Canny';
    dims = [1 35];
    definput = {'0.05', '0.15', '15', '255', '5', '0', '1'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    %parametros do metodo de canny
    limiar_baixo = str2double(answer{1});
    limiar_alto = str2double(answer{2});
    fraco = str2double(answer{3});
    forte = str2double(answer{4});
    tam_mascara = str2double(answer{5});
    mu = str2double(answer{6});
    sigma = str2double(answer{7});
    %inicio das chamadas feitas especificamente para esse proposito
    mascara = kernel_gaussiano(tam_mascara, mu, sigma); 
    disp(mascara);
    fonte_suavizada = conv2d_isr(fonte, mascara);
    [~, ~, grad_fonte_sobel, fase_fonte_sobel] = sobel_canny(fonte_suavizada);
    non_max_fonte = non_max_sup(grad_fonte_sobel, fase_fonte_sobel);
    fonte_limiarizada = limiar_aux_canny(non_max_fonte, fraco , forte, limiar_baixo, limiar_alto);
    resultado = hysteresis(fonte_limiarizada, fraco, forte);  
    axes(handles.axes2)
    imshow(uint8(resultado));

end


% --------------------------------------------------------------------
function Filtros_Callback(hObject, eventdata, handles)
% hObject    handle to Filtros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function [h, p_r, bins] = hist_imagem_isr(A)
    %esta função supõe que a imagem A está já está em nível de cinza
    % B = rgb2gray(A);
    %B = double(A);
    L = 256;
    h = zeros(1,L);
    bins = 0:L-1;
    %Processameneto do histograma para a imagem B
    A = A(:);
    for k = 0:L-1
        h(k+1) = sum(A==k);
    end
    p_r = h/numel(A);
    p_r = p_r/sum(p_r);%Normalizando
    %garantindo que o retorno sejam vetores colunas
    p_r = p_r(:);
    bins = bins(:);
    h = h(:);
end


function Histogramas_Callback(hObject, eventdata, handles)
% hObject    handle to Histogramas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Auto_Escala_Callback(hObject, eventdata, handles)
% hObject    handle to Auto_Escala (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte, 3) == 3
        %Aplicacao da Transformacao de auto escala por canal de cor
        fonte = double(fonte);
        f_R = unique(fonte(:,1));
        f_G = unique(fonte(:,2));
        f_B = unique(fonte(:,3));
        fR_min = min(f_R(:));
        fR_max = max(f_R(:));
        fG_min = min(f_G(:));
        fG_max = max(f_G(:));
        fB_min = min(f_B(:));
        fB_max = max(f_B(:));
        clear f_R f_G f_B
        [M, N, ~] = size(fonte);
        resultado = zeros(size(fonte));
        resultado_R = zeros(size(fonte,1),size(fonte,2));
        resultado_G = zeros(size(fonte,1),size(fonte,2));
        resultado_B = zeros(size(fonte,1),size(fonte,2));
        %Pedaco de codigo para retirar o uso do for e fazer a auto escala
        %isso e o que faz o algoritmo ficar mais funcional
        [M, N] = meshgrid(1:M, 1:N);
        M = M(:);
        N = N(:);
        idx = sub2ind([size(resultado,1), size(resultado,2)], M, N);
        R = fonte(:,:,1);
        k = R(idx);
        resultado_R(idx) = (255/(fR_max-fR_min)).*(k - fR_min);
        G = fonte(:,:,2);
        k = G(idx);
        resultado_G(idx) = (255/(fG_max-fG_min)).*(k - fG_min);
        B = fonte(:,:,3);
        k = B(idx);
        clear R G B M N; 
        resultado_B(idx) = (255/(fB_max-fB_min)).*(k - fB_min);
        resultado(:,:,1) = resultado_R;
        resultado(:,:,2) = resultado_G;
        resultado(:,:,3) = resultado_B;
        clear k idx resultado_R resultado_G resultado_B;
%         for x = 1:M
%             for y = 1:N
%                 k = fonte(x, y, 1);
%                 g = (255/(fR_max-fR_min)).*(k - fR_min);
%                 resultado(x, y, 1) = g;
%                 
%                 k = fonte(x, y, 2);
%                 g = (255/(fG_max-fG_min)).*(k - fG_min);
%                 resultado(x, y, 2) = g;
%                 
%                 k = fonte(x, y, 3);
%                 g = (255/(fB_max-fB_min)).*(k - fB_min);
%                 resultado(x, y, 3) = g;
%             end
%         end
        
        
    else
        %Aplicacao da Transformacao no tom de cinza
        fonte = double(fonte);
        f = unique(fonte(:));
        f_min = min(f(:));
        f_max = max(f(:));
        clear f;
        [M, N] = size(fonte);
        [M, N] = meshgrid(1:M, 1:N);
        M = M(:);
        N = N(:);
        resultado = zeros(size(fonte,1), size(fonte,2));
        idx = sub2ind(size(resultado), M, N);
        k = fonte(idx);
        resultado(idx) = (255/(f_max-f_min)).*(k - f_min); 
        clear k idx M N;
%         for x = 1:M
%             for y = 1:N
%                 k = fonte(x,y);
%                 g = (255/(f_max-f_min)).*(k - f_min);
%                 resultado(x, y) = g;
%             end
%         end
    end
    axes(handles.axes2);
    resultado = uint8(resultado);
    imshow(resultado);

end

% --------------------------------------------------------------------
function Equalizacao_Callback(hObject, eventdata, handles)
% hObject    handle to Equalizacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    %Inicio do algoritmo feito equalizacao por canal de cor ou no nivel de
    %cinza
    L = 255;
    if size(fonte,3) == 3
        R = double(fonte(:,:,1));
        G = double(fonte(:,:,2));
        B = double(fonte(:,:,3));
        [~, prob_R, ~] = hist_imagem_isr(R);
        [~, prob_G, ~] = hist_imagem_isr(G);
        [~, prob_B, ~] = hist_imagem_isr(B);
        cdf_fonteR = cumsum(prob_R);
        cdf_fonteG = cumsum(prob_G);
        cdf_fonteB = cumsum(prob_B);
        %Transformacao de CDF 
        cdf_transR_uni = round(L*cdf_fonteR);
        cdf_transG_uni = round(L*cdf_fonteG);
        cdf_transB_uni = round(L*cdf_fonteB);
        resultado = zeros(size(fonte));
        resultado_R = zeros(size(fonte, 1), size(fonte, 2));
        resultado_G = zeros(size(fonte, 1), size(fonte, 2));
        resultado_B = zeros(size(fonte, 1), size(fonte, 2));
        [M, N, ~] = size(resultado);
        [M, N] = meshgrid(1:M, 1:N);
        M = M(:);
        N = N(:);
        idx = sub2ind([size(resultado,1), size(resultado,2)], M, N);
        clear M N;
        for i = 1:length(idx)
            k = R(idx(i));
            resultado_R(idx(i)) = cdf_transR_uni(k+1);%soma 1 pq é o indice
            k = G(idx(i));
            resultado_G(idx(i)) = cdf_transG_uni(k+1);%soma 1 pq é o indice
            k = B(idx(i));
            resultado_B(idx(i)) = cdf_transB_uni(k+1);%soma 1 pq é o indice
        end
        resultado(:,:,1) = resultado_R;
        resultado(:,:,2) = resultado_G;
        resultado(:,:,3) = resultado_B;
        resultado = uint8(resultado);
        clear R G B idx;
        clear resultado_R resultado_G resultado_B;
        [~, p_R_res, ~] = hist_imagem_isr(resultado(:,:,1));
        [~, p_G_res, ~] = hist_imagem_isr(resultado(:,:,2));
        [~, p_B_res, bins] = hist_imagem_isr(resultado(:,:,3));
        %Calculo da distribuicao media para efeito de visualizacao da
        %transformacao realizada
        p_fonte = (prob_R + prob_G + prob_B)/3;
        cdf_fonte = (cdf_fonteR + cdf_fonteG + cdf_fonteB)/3;
        p_resultado = (p_R_res + p_G_res + p_B_res)/3;
        cdf_resultado = (cdf_transR_uni + cdf_transG_uni + cdf_transB_uni)/3; 
        clear p_R_res p_G_res p_B_res prob_R prob_G prob_B;
        clear cdf_fonteR cdf_fonteG cdf_fonteB cdf_transR_uni cdf_transG_uni cdf_transB_uni
        axes(handles.axes2);
        imshow(resultado);

        axes(handles.axes3);
        bar(bins, p_fonte)
        ylim([0 max(p_fonte)])

        axes(handles.axes4);
        bar(bins, p_resultado)
        ylim([0 max(p_resultado)])

        prompt = {'Visualizar CDFs (1 - sim, qq outra coisa nao):'};
        dlgtitle = 'CDFS';
        dims = [1 35];
        definput = {'1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        if isempty(answer)
            return
        end
        ver_cdf = str2num(answer{1});
        if ver_cdf == 1
            figure
            subplot(211)
            plot(bins, cdf_fonte), title('CDF-FONTE');
            subplot(212)
            plot(bins, cdf_resultado), title('CDF-RESULTADO');
        else
            return;
        end
    else
        fonte = double(fonte);
        [~, p_fonte, ~] = hist_imagem_isr(fonte);
        cdf_fonte = cumsum(p_fonte);
        %transformacao de CDF
        cdf_trans_uniforme = round(L*cdf_fonte);
        resultado = zeros(size(fonte));
        [M, N] = size(resultado);
        [M, N] = meshgrid(1:M, 1:N);
        M = M(:);
        N = N(:);
        idx = sub2ind(size(resultado), M, N);
        k = fonte(idx);
        clear M N;
        for i = 1:length(idx)
            resultado(idx(i)) = cdf_trans_uniforme(k(i)+1);%soma 1 pq é o indice
        end
        clear idx k;
%         for x = 1:M
%             for y = 1:N
%                 k = fonte(x,y);
%                 resultado(x,y) = 
%             end
%         end
        resultado = uint8(resultado);
        [~, p_resultado, bins] = hist_imagem_isr(resultado);
        cdf_resultado = cumsum(p_resultado);
        axes(handles.axes2);
        imshow(resultado);

        axes(handles.axes3);
        bar(bins, p_fonte)
        ylim([0 max(p_fonte)])

        axes(handles.axes4);
        bar(bins, p_resultado)
        ylim([0 max(p_resultado)])

        prompt = {'Visualizar CDFs (1 - sim, qq outra coisa nao):'};
        dlgtitle = 'CDFS';
        dims = [1 35];
        definput = {'1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        if isempty(answer)
            return
        end
        ver_cdf = str2num(answer{1});
        if ver_cdf == 1
            figure
            subplot(211)
            plot(bins, cdf_fonte), title('CDF-FONTE');
            subplot(212)
            plot(bins, cdf_resultado), title('CDF-RESULTADO');
        else
            return;
        end
    end
        
end

% --------------------------------------------------------------------
function Limiarizacao_Callback(hObject, eventdata, handles)
% hObject    handle to Limiarizacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------


function  C  = conv2d_mediana_isr(A, B)

    A = double(A);
    %matriz que recebera a operação
    C = zeros(size(A));

    % vetorização e para e inversão dos eixos da mascara para a operação de con
    %volucao
    kernel_vetorizado = reshape(flip(flip(B,1),2)' ,[] , 1);

    % preenchendo com zeros a matriz para operação da convolução e fazendo a
    % operação em cima da matriz orignal uma 
    Imagem_zeros = padarray(A, [floor(size(B,1)/2) floor(size(B,2)/2)]);
    ordena_kernel = sort(kernel_vetorizado);
    M = length(ordena_kernel);
    clear kernel_vetorizad ordena_kernel;
    %Teste para saber se o tamanho do vetor e par ou impar e poder pegar o
    %valor certo
    if mod(M, 2) == 0
        k1 = fix(M/2);
        k2 = k1 + 1;
        for i = 1:size(A,1)
            for j = 1:size(A,2)
                imagem_vet_zeros = reshape(Imagem_zeros(i: i + size(B,1) - 1, j:j + size(B,2) - 1)',1,[]);
                imagem_vet_zeros = sort(imagem_vet_zeros);
                C(i,j) = (imagem_vet_zeros(k1) + imagem_vet_zeros(k2))/2;
            end
        end
    else
        k1 = fix(M/2);
        for i = 1:size(A,1)
            for j = 1:size(A,2)
                imagem_vet_zeros = reshape(Imagem_zeros(i: i + size(B,1) - 1, j:j + size(B,2) - 1)',1,[]);
                imagem_vet_zeros = sort(imagem_vet_zeros);
                C(i,j) = imagem_vet_zeros(k1);
            end
        end
    end

end

function Media_Callback(hObject, eventdata, handles)
% hObject    handle to Media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Entre com o valor da mascara de Media: '};
    dlgtitle = 'Media';
    dims = [1 35];
    definput = {'3'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    tipo_media = str2num(answer{1});
    if or(isempty(tipo_media), ~isnumeric(tipo_media))
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    if tipo_media < 0
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    %Construcao da mascara para filtragem de media
    mascara = ones(tipo_media);
    mascara = mascara./numel(mascara);
    
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    fonte = double(fonte);
    
    if size(fonte,3) == 3
        resultado = zeros(size(fonte));
        resultado(:,:,1) = conv2d_isr(fonte(:,:,1), mascara);
        resultado(:,:,2) = conv2d_isr(fonte(:,:,2), mascara);
        resultado(:,:,3) = conv2d_isr(fonte(:,:,3), mascara);
    else
        resultado = conv2d_isr(fonte, mascara);

    end
    
    
    axes(handles.axes2);
    imshow(uint8(resultado));
    
end

% --------------------------------------------------------------------
function Mediana_Callback(hObject, eventdata, handles)
% hObject    handle to Mediana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Entre com o tamanho da mascara de Mediana: '};
    dlgtitle = 'Mediana';
    dims = [1 35];
    definput = {'3'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    tipo_media = str2num(answer{1});
    if or(isempty(tipo_media), ~isnumeric(tipo_media))
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    if tipo_media < 0
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    mascara = ones(tipo_media);
    mascara = mascara./numel(mascara);
    
    fonte = getimage(handles.axes1);
    
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    %Filtragem usa uma modificacao feita na minha funcao de convolucao para
    %pegar o valor correto do pixel a ser atribuido na imagem resultado
    fonte = double(fonte);
    if size(fonte,3) == 3
        resultado = zeros(size(fonte));
        resultado(:,:,1) = conv2d_mediana_isr(fonte(:,:,1), mascara);
        resultado(:,:,2) = conv2d_mediana_isr(fonte(:,:,2), mascara);
        resultado(:,:,3) = conv2d_mediana_isr(fonte(:,:,3), mascara);
    else
        resultado = conv2d_mediana_isr(fonte, mascara);

    end
    
    
    axes(handles.axes2);
    imshow(uint8(resultado));

end

% --------------------------------------------------------------------
function Gaussiano_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussiano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    prompt = {'Entre com o tamanho da mascara Gaussiana: '};
    dlgtitle = 'Gaussiano';
    dims = [1 35];
    definput = {'3'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    tipo_gauss = str2num(answer{1});
    if or(isempty(tipo_gauss), ~isnumeric(tipo_gauss))
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    if tipo_gauss < 0
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    [xx, yy] = meshgrid(-floor(tipo_gauss/2):floor(tipo_gauss/2));
    %Gaussiana de media nula e variancia unitaria
    sigma = 1;
    mascara = (1/(2*pi*sigma^2))*exp(-(xx.^2 + yy.^2)/(2*(sigma^2)));
    
    fonte = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    %FILTRAGEM
    fonte = double(fonte);
    if size(fonte,3) == 3
        resultado = zeros(size(fonte));
        resultado(:,:,1) = conv2d_isr(fonte(:,:,1), mascara);
        resultado(:,:,2) = conv2d_isr(fonte(:,:,2), mascara);
        resultado(:,:,3) = conv2d_isr(fonte(:,:,3), mascara);
    else
        resultado = conv2d_isr(fonte, mascara);

    end
    
    
    axes(handles.axes2);
    imshow(uint8(resultado));


end

% --------------------------------------------------------------------
function High_Boost_Callback(hObject, eventdata, handles)
% hObject    handle to High_Boost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Entre com o tamanho de A: Maior ou igual a 1'};
    dlgtitle = 'High-Boost';
    dims = [1 35];
    definput = {'1'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    A = str2num(answer{1});
    if or(isempty(A), ~isnumeric(A))
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
    
    if A < 0
        msgbox(sprintf('Opcao invalida'),'error','error');
        return
    end
   
    mascara = (1/9)*-1*ones(3,3);
    w = 9*A - 1;
    mascara(2,2) = w;
    
    fonte = getimage(handles.axes1);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    fonte = double(fonte);
    if size(fonte,3) == 3
        resultado = zeros(size(fonte));
        resultado(:,:,1) = conv2d_isr(fonte(:,:,1), mascara);
        resultado(:,:,1) = (A-1)*fonte(:,:,1) + resultado(:,:,1);
        resultado(:,:,2) = conv2d_isr(fonte(:,:,2), mascara);
        resultado(:,:,2) = (A-1)*fonte(:,:,2) + resultado(:,:,2);
        resultado(:,:,3) = conv2d_isr(fonte(:,:,3), mascara);
        resultado(:,:,3) = (A-1)*fonte(:,:,3) + resultado(:,:,3);
    else
        resultado = conv2d_isr(fonte, mascara);
        resultado = (A-1)*fonte + resultado;

    end
    
    
    axes(handles.axes2);
    imshow(uint8(resultado));

end

% --------------------------------------------------------------------
function Global_Callback(hObject, eventdata, handles)
% hObject    handle to Global (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    %Metodo Limiarizador Iterativo GLOBAL
    [~, p_fonte, ~] = hist_imagem_isr(fonte);
    T1 = mean(fonte(:)); %intensidade média - T_novo
    T2 = 0;               %T_antigo
    iter = 1;
    dt = 0;
    teste = abs(T1 - T2); 
    
    while teste > dt
        if iter > 100
            break;
        end
        G1 = (fonte > T1).*fonte;
        G2 = (fonte <= T1).*fonte;
        M1 = mean(G1(:));
        M2 = mean(G2(:));
        T2 = T1; 
        T1 = (M1 + M2)/2;
        teste = abs(T1 - T2);
        fprintf('Iteracao: %d \n', iter);
        iter = iter + 1;

    end
    if M1 == 0
        T = M2;
    else if M2 == 0
            T = M1;
        else
            T = T1;
        end
    end
    fprintf('Teste: %.3f\n', teste);
    fprintf('Limiar Global: %.3f\n', T);
    axes(handles.axes2);
    resultado = (fonte > T);
    imshow(uint8(resultado*255)), drawnow;
end

% --------------------------------------------------------------------

function [T] = limiar_otsu_isr2(im_hist, K)
    %recebe o histograma da imagem de entrada e o vetor de pixels K
    p_i = im_hist;
    P1_k = cumsum(p_i);
%     P2_k = 1 - P1_k;
    M_k = cumsum(K'.*p_i + eps);
    mg = K*p_i;
    sig_b_2 = ((mg*P1_k - M_k).^2)./((P1_k.*(1 - P1_k)) + eps);
    [~, I] = max(sig_b_2);
    T = K(I(1)+1);
end



function [T] = limiar_otsu_isr(im_hist, K)
%   Minha versao com FOR
    total = sum(im_hist);
    L = 256;
    soma_fundo = 0;
    fundo = 0;
    maximum = 0.0;
    media_total = K*im_hist;
    for ii = 1:L
        nao_fundo = total - fundo;
        if and(fundo > 0, nao_fundo > 0)
            media_nao_fundo = (media_total - soma_fundo) / nao_fundo;
            val = fundo*nao_fundo*((soma_fundo/fundo) - media_nao_fundo)^2;
            if ( val >= maximum )
                T = ii;
                maximum = val;
            end
        end
        fundo = fundo + im_hist(ii);
        soma_fundo = soma_fundo + (ii-1) * im_hist(ii);
    end
end


function Otsu_Callback(hObject, eventdata, handles)
% hObject    handle to Otsu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    [~, p_fonte, K] = hist_imagem_isr(fonte);
    K = reshape(K, 1, length(K));
    T2 = limiar_otsu_isr2(p_fonte, K);
    %Etapa de Testes
%     disp('Medindo tempo para OTSU com FOR');
%     tic;
%     [~, p_fonte, pixels] = hist_imagem_isr(fonte);
%     T1 = limiar_otsu_isr(p_fonte, K);
%     toc;
% %     fprintf('TEMPO OTSU COM FOR: %.3f\n\n', t1_fin - t1_ini);
%     
%     disp('Medindo tempo para OTSU sem FOR');
%     tic;
%     [~, p_fonte, pixels] = hist_imagem_isr(fonte);
%     T2 = limiar_otsu_isr2(p_fonte, K);
%     toc;
%         
%     disp('Medindo tempo para OTSU MATLAB');
%     tic;
%     T3 = round(255*graythresh(fonte/255));
%     toc;
% %     fprintf('TEMPO OTSU SEM FOR: %.3f\n\n', t2_fin - t2_ini);
%     
%     fprintf('Limiar OTSU1: %.3f\n', T1);
    fprintf('Limiar OTSU2: %.3f\n', T2);
%     fprintf('Limiar OTSU-MATLAB: %.3f\n', T3);
    axes(handles.axes2);
    resultado = fonte > T2;
    imshow(uint8(resultado*255));
end


% --------------------------------------------------------------------
function Laplaciano_Realce_Callback(hObject, eventdata, handles)
% hObject    handle to Laplaciano_Realce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function Realce_em_Etapas_Callback(hObject, eventdata, handles)
% hObject    handle to Realce_em_Etapas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function [Eroded] = erosao_israel(fonte, estruc_el)
            
    [linha, coluna]=size(estruc_el);  

    % Matriz que guardara os processos         
    Eroded = zeros(size(fonte, 1), size(fonte, 2));  

    for i = ceil(linha/2):size(fonte, 1)-floor(linha/2) 
        for j = ceil(coluna/2):size(fonte, 2)-floor(coluna/2) 

            % captando a vizinhança do pixel centrado na coordenada i, j
            pedaco_fonte = fonte(i-floor(linha/2):i+floor(linha/2), j-floor(coluna/2):j+floor(coluna/2));  

            % Fazendo a imagem ser do tipo logica
            vizinhanca = pedaco_fonte(logical(estruc_el));  

            %comparo e atribuo o menor valor
            Eroded(i, j) = min(vizinhanca(:));       
        end
    end
  
end

function [Dilated] = dilacao_israel(fonte, estruc_el)

    [linha, coluna]=size(estruc_el);  

    % Matriz que guardara os processos         
    Dilated = zeros(size(fonte, 1), size(fonte, 2));  

    for i = ceil(linha/2):size(fonte, 1)-floor(linha/2) 
        for j = ceil(coluna/2):size(fonte, 2)-floor(coluna/2) 

            % captando a vizinhança do pixel centrado na coordenada i, j
            pedaco_fonte = fonte(i-floor(linha/2):i+floor(linha/2), j-floor(coluna/2):j+floor(coluna/2));  

            %  Fazendo a imagem ser do tipo logica
            vizinhanca = pedaco_fonte(logical(estruc_el));  

            %comparo e atribuo o menor valor 
            Dilated(i, j) = max(vizinhanca(:));       
        end
    end

end

function [Result] = abertura_israel(fonte, estruc_el)

    temp = erosao_israel(fonte, estruc_el);
    Result = dilacao_israel(temp, estruc_el);
end


function [Result] = fechamento_israel(fonte, estruc_el)
    
    temp = dilacao_israel(fonte, estruc_el);
    Result = erosao_israel(temp, estruc_el);
end

function Morfologia_Callback(hObject, eventdata, handles)
% hObject    handle to Morfologia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function Segmentacao_Callback(hObject, eventdata, handles)
% hObject    handle to Segmentacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function Caracteristicas_Callback(hObject, eventdata, handles)
% hObject    handle to Caracteristicas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function Erosao_Callback(hObject, eventdata, handles)
% hObject    handle to Erosao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    
    %teste para saber se a imagem e binaria ou nao, caso seja nao sera
    %binarizada
    if length(unique(fonte)) == 2
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = erosao_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    else
        [~, p_fonte, K] = hist_imagem_isr(fonte);
        K = reshape(K, 1, length(K));
        T2 = limiar_otsu_isr2(p_fonte, K);
        fonte = fonte > T2;
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = erosao_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    end
    
    
end

% --------------------------------------------------------------------
function Dilacao_Callback(hObject, eventdata, handles)
% hObject    handle to Dilacao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    %teste para saber se a imagem e binaria ou nao, caso seja nao sera
    %binarizada
    if length(unique(fonte)) == 2
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = dilacao_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    else
        [~, p_fonte, K] = hist_imagem_isr(fonte);
        K = reshape(K, 1, length(K));
        T2 = limiar_otsu_isr2(p_fonte, K);
        fonte = fonte > T2;
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = dilacao_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    end
    
end

% --------------------------------------------------------------------
function Abertura_Callback(hObject, eventdata, handles)
% hObject    handle to Abertura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    %teste para saber se a imagem e binaria ou nao, caso seja nao sera
    %binarizada
    if length(unique(fonte)) == 2
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = abertura_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    else
        [~, p_fonte, K] = hist_imagem_isr(fonte);
        K = reshape(K, 1, length(K));
        T2 = limiar_otsu_isr2(p_fonte, K);
        fonte = fonte > T2;
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = abertura_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    end
    
end

% --------------------------------------------------------------------
function Fechamento_Callback(hObject, eventdata, handles)
% hObject    handle to Fechamento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
        axes(handles.axes1);
        imshow(fonte);
    end
    
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    %teste para saber se a imagem e binaria ou nao, caso seja nao sera
    %binarizada
    if length(unique(fonte)) == 2
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = fechamento_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    else
        [~, p_fonte, K] = hist_imagem_isr(fonte);
        K = reshape(K, 1, length(K));
        T2 = limiar_otsu_isr2(p_fonte, K);
        fonte = fonte > T2;
        se = [0 1 0; 0 1 0; 0 1 0];
        resultado = fechamento_israel(fonte, se);
        axes(handles.axes2);
        imshow(uint8(255*resultado));
    end
    
    
end


% --------------------------------------------------------------------
%Funcoes utilizadas no processo de segmentacao pelo método de Amostragem da
%distribuicao de GIBBS
function mult_img = cinza_2_multiniveis_israel(fonte, limiar)
%Funcao que sera usada para criar uma limiarizacao inicial a ser usada 
%no sistema de segmentacao

    mult_img = zeros(size(fonte));
    mult_img(fonte < limiar(1)) = 1;
    n_limiar = length(limiar);
    if (n_limiar > 1)
        for i = 1:n_limiar - 1
            mult_img(fonte >= limiar(i) & fonte <limiar(i+1)) = i + 1;
        end
        mult_img(fonte >= limiar(i+1)) = i + 2;
    else
        mult_img(fonte >= limiar(1)) = 2;
    end
end

function [mu, stds] = estas_regiao(fonte, img_reg, n_classes)
    
%Esta funcao calcula as estatisticas de cada regiao da imagem associadas ao
%aos labels iniciais

    mu = zeros(size(n_classes, 1));
    stds = mu;
    for i = 1:n_classes
            H = fonte(img_reg == i);
            if ~isempty(H)
                mu(i) = mean(H);
                stds(i) = std(H);
            else
                mu(i) = 0;
                stds(i) = 0;
            end
    end
            
end

function energia = energia_total_israel(fonte, clus, mus, vars, i, j, label, beta)
    %Calculo da Energia Total usada na maximização da Posterioris
    energia = prob_logaritmica(fonte, mus, vars, i, j, label) + ...
              energia_gibbs(clus, i, j, label, beta);
end


function p_lol = prob_logaritmica(img,mu,vars,i,j,label)
% img é a imagem com os niveis de cinza
p_lol = log((2.0*pi*vars(label)^0.5)) + ...
    (img(i,j)-mu(label))^2/(2.0*vars(label));
end

function energia = energia_gibbs(img,i,j,label,beta)
% img é a imagem com os nomes dos agrupamentos
energia = 0;
%Norte, sul, Leste, Oeste
if (label == img(i-1,j)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
%Diagonais
if (label == img(i-1,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i-1,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end

end

function clust = gibbs_segment_israel(fonte, label, beta, n_regioes, iter)
%

fonte = padarray(fonte, [1 1], 'replicate', 'both');
label = padarray(label, [1 1], 'replicate', 'both');
[linha, coluna] = size(fonte);

%Parâmetros da Têmpera Simulada
T = 4; C = 0.97; 

[mus, sigs] = estas_regiao(fonte(2:end-1, 2:end-1), ...
                           label(2:end-1, 2:end-1), n_regioes);
vars = (sigs + .01).^2; %para evitar erro numerico
for i = 1:iter
    %Amostrando um numero da distribuicao uniforme na faixa
    %da linha e da coluna
    U = random('Uniform', 0, 1, linha, coluna);
    for i = 2:linha-1
        for j = 2:coluna - 1
            %Calculo Da Energia para cara regiao do Sistema (nossa Imagem)
            ss = label(i,j);
            soma_energia = 0;
            e = zeros(n_regioes, 1);
            for s = 1:n_regioes
                e(s) = exp(-energia_total_israel(fonte, label, mus, vars,...
                       i, j, s, beta))/T;
                soma_energia = soma_energia + e(s);
            end
            %Iniciando de amostragem da Distribuicao de Energia de Gibbs
            F = 0;
            for s = 1:n_regioes
                F = F + e(s)/soma_energia;
                if F >= U(i,j)
                    label(i,j) = s;
                    break;
                end
            end
        end
    end
    T = T*C;
    [mus, sigs] = estas_regiao(fonte(2:end-1, 2:end-1), ...
                           label(2:end-1, 2:end-1), n_regioes);
    vars = (sigs + .01).^2; %para evitar erro numerico
 
end
   clust = label;                 
end



function Gibbs_Callback(hObject, eventdata, handles)
% hObject    handle to Gibbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%O metodo de amostragem de gibbs surge da perspectiva de se interpretar a 
%imagem como um Campo Aleatorio de Markov, seguindo todas as formulacoes da
%teoria de probabilidade e do processamento estocastico de Imagens. O
%metodo diz que ao supormos a imagem com regioes distintas entre si, e
%possível estimar as densidades de probabilidade de cada regiao. A escolha
%da densidade de probabilidade das regioes como sendo as de gibbs é feita
%devido a simplicidade de se trabalhar com o conceito de energia associado
%a cada pixel da imagem. Uma vez que temos a imagem, e temos uma densidade
%de probabilidade definida, é montado um problema de otimizacao em que
%tentamos minimizar a probabilidade a posteriori do pixel pertencer a cada
%uma das regioes. A forma que eu resolvi o problema de otimizacao foi
%baseado na Tempera Simulada, em que, por analogia ao problema físico,
%supomos que a superficie formada pelos pixels da imagem estão esquentados.
%Esta suposicao é equivalente a dizer que cada pixel tem igual
%probabilidade de ser amostrado a partir da distribuição original. A medida
%em que a etapa de otimização é sendo feita, a temperatura vai diminuindo e
%é esperado que no estado estável, a estrutura resfriada, a imagem resultan
%te tenha ocupado as regiões que minimizam a configuracao de energia
%inicial. 
%Como todo problema de otimizacao, parametros iniciais sao necessarios para
%que o algoritmo possa iniciar. Eu escolhi implementar com no maximo 5
%limiares de pixels por imagem. Além disso, eu mostro o histograma da
%imagem original porque na funcao cinza_2_multiniveis_israel, um mapa
%inicial das regioes e criado. Eu crio os meus mapas me baseando no
%histograma da imagem a ser segmentada, escolhendo os valores de pico, ou
%os que eu ache que são mais relevantes para tal tarefa. Uma boa discussao
%que é levantada é: Qual o melhor valor de beta? Os meus 1.5 funcionaram
%bem nos meus testes, porém o pessoal diz que isso é um problema em aberto
%e métodos de otimização deste parâmetro foram desenvolvidas. Daí as
%ferramentas otimizam, ao mesmo tempo, a propabilidade a priori da regiao,
%e o parâmetro beta. Os resultados são legais, mas, dentro do meu
%entendimento, não faz muito sentido buscar por esse tipo de solução uma
%vez que computacionalmente ela é custosa. A não ser que a precisão da
%solução seja um fator pre ponderante!!!!
%
%






    fonte = getimage(handles.axes1);
    fonte = double(fonte);
    %Verifica se tem imagem no axes1
    if isempty(fonte)
        
        [impath1, user_canceled] = imgetfile;

        if user_canceled
            msgbox(sprintf('Cancelada pelo usuario!\nA operacao nao pode ser concluida'),'error','error');
            return;
        end
        
        fonte = imread(impath1);
    end
        
    if size(fonte,3) == 3
        fonte = (0.2989*fonte(:,:,1) + 0.5870*fonte(:,:,2) + 0.1140*fonte(:,:,3));
    end
    
    axes(handles.axes1);
    imshow(uint8(fonte));
    
    fonte = double(uint8(fonte));%garantindo que os niveis de cinza estao entre 0 - 255
    [~, p_fonte, bins] = hist_imagem_isr(fonte);
    axes(handles.axes3);
    bar(bins, p_fonte, 'b'), grid on, title('Histograma - Fonte');
    %Limiares inicias
    prompt = {'lim1:','lim2:','lim3:', 'lim4:', 'lim5:'};
    dlgtitle = 'Limiares';
    dims = [1 35];
    definput = {'0','0', '0', '0', '0'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    lim1 = str2num(answer{1});
    lim2 = str2num(answer{2});
    lim3 = str2num(answer{3});
    lim4 = str2num(answer{4});
    lim5 = str2num(answer{5});
    
    lim = [lim1 lim2 lim3 lim4 lim5];
    if sum(lim) < 0
        return;
    end
    lim = lim(lim > 0 & lim <= 255); 
    fonte_mult_level = cinza_2_multiniveis_israel(fonte, lim);
    prompt = {'beta:','iter:'};
    dlgtitle = 'Parametros de Otimizacao';
    dims = [1 35];
    definput = {'1.5','30'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    beta = str2num(answer{1});%Parametro da PDF de Gibbs
    iter = str2num(answer{2});%Numero de Iteracoes para rodar o Algoritmo
    resultado = gibbs_segment_israel(fonte, fonte_mult_level, beta, ...
                                    length(lim)+1, iter);
    axes(handles.axes2);
    imagesc(resultado),axis off, axis equal, colormap(gray);


end