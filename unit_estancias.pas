unit unit_estancias;
 
interface
const n=1000;

Type
T_estancia=record
    ID_Estancia : integer;
    nombreEstancia:string;
    apellNomDueno:String;
    Dni:Integer;
    domicilio:String;
    cod_provincia: Integer;
    numeroContacto:Integer;
    email:String;
    caracteristicas:String;
    tienePiscina:Boolean;
    capacidadMaxima:Integer;
    alta:Boolean;
end;

T_provincias= record
  Denominacion:String;
  cod_provincia: Integer;
  Telefono:Integer
  end;

archivo_Provincia= file of T_provincias;
archivo=file of T_estancia;
T_vector= array [1..n] of T_estancia;


procedure incializarRegistro(var registroE:T_estancia);
procedure CargarRegistroEstancia (var registroE:T_estancia);
procedure mostrarEstancia (estanciaE : T_estancia);
function Posicion( N:String; var archiv:archivo):Integer;
procedure altaEstancia (var registroE:T_estancia; var archiv: archivo);
procedure baja(var archiv:archivo; var estancia : T_estancia; posicionEstancia : integer);
procedure ConsultarEstancia (var estanciaE: T_estancia; var archiv:archivo);
procedure modificarEstancia(var archiv:archivo);
procedure consultar(var archiv:archivo);
procedure incializarRegistroProvincia(var registroP:T_provincias);
procedure CargarRegistroProvincia (var registroP:T_provincias);
function PosicionProvincia( N:String; var archivoP:archivo_Provincia):Integer;
procedure altaProvincia (var registroP:T_provincias; var archivoP: archivo_Provincia);
procedure LeerArchivo(var archiv:archivo; var v:T_vector; var lim:integer);
procedure ModificarArchivo(var archiv:archivo; var v:T_vector; var lim:Integer);  //modifica el archivo guardando los registros ordenados
procedure listado (var archiv:archivo);
procedure burbuja( var v:T_vector; lim: Integer);
procedure listadoPiscinas(var archiv : archivo);



IMPLEMENTATION

procedure incializarRegistro(var registroE:T_estancia);
begin
    //contadorEstancias := contadorEstancias + 1;var contadorEstancias : integer
      with registroE do 
      begin
        //ID_Estancia:= contadorEstancias;
        nombreEstancia:=' ';
        apellNomDueno:=' ';
        Dni:=0;
        domicilio:= ' '; 
        cod_provincia:= 0;
        numeroContacto:=0;
        email:='';
        caracteristicas:='';
        tienePiscina:=false;
        capacidadMaxima:=0;
        alta:=true;
        
      end;
end;

procedure CargarRegistroEstancia (var registroE:T_estancia);
var 
  aux : string;
begin

  with registroE do
    begin
      WriteLn('ingrese el nombre de la estancia');
      ReadLn(nombreEstancia);
      WriteLn('ingrese el apellido y nombre del dueño ');
      ReadLn(apellNomDueno);
      WriteLn('ingrese el DNI');
      ReadLn(Dni);
      WriteLn('ingrese su domicilio');
      ReadLn(domicilio);
      WriteLn('Ingrese el código de provincia');
      ReadLn(cod_provincia);
      WriteLn('ingrese un numero de contacto');
      ReadLn(numeroContacto);
      WriteLn('ingrese su email');
      ReadLn(email);
      WriteLn('caracterice la estancia');
      ReadLn(caracteristicas);
      WriteLn('¿tiene piscina? s/n');
      ReadLn(aux);
        if(aux = 's') then tienePiscina := true;        //Si se ingresa 's', tienePiscina es true. Si se ingresa algo distinto a 's', no pasa nada y conserva el valor false con el que se inicializó
      WriteLn('capacidad maxima de la estancia');
      ReadLn(capacidadMaxima);
      alta := true;            
    end;
end;

procedure mostrarEstancia (estanciaE : T_estancia);
begin
  with estanciaE do
    begin
      WriteLn('nombre de la estancia');
      writeln(nombreEstancia);
      WriteLn('apellido y nombre del dueño ');
      writeln(apellNomDueno);
      WriteLn('el DNI');
      writeln(Dni);
      WriteLn('domicilio');
      writeln(domicilio);
      Writeln('Código de provincia:');
      WriteLn(cod_provincia);
      WriteLn('numero de contacto');
      writeln(numeroContacto);
      WriteLn('email');
      writeln(email);
      WriteLn('características de la estancia');
      writeln(caracteristicas);
      WriteLn('¿tiene piscina?');
      writeln(tienePiscina);
      WriteLn('capacidad maxima de la estancia');
      writeln(capacidadMaxima);
    end;
end;

function Posicion( N:String; var archiv:archivo):Integer;
var 
registro:T_estancia;
encontrado:Boolean;
posicionArchivo : integer;

begin
  //Inicialización de variables
  encontrado:=false;
  posicionArchivo := 0;
  seek(archiv, posicionArchivo);
  //Ciclo mientras NO sea el final del archivo y NO se haya encontrado
  while not Eof(archiv) and not encontrado do 
  begin
    //Posicionamiento en el archivo
    seek(archiv, posicionArchivo);
    
    //Lectura de la variable
    read(archiv,registro);

    //Comprobación: el nombreEstancia es igual al nombre ingresado?
    if registro.nombreEstancia = N then
      encontrado:= true
    else 
      //Actualización para la próxima iteración
      posicionArchivo := posicionArchivo + 1;
  end;
WriteLn('encontrado ', encontrado );
WriteLn('posicion archivo ',posicionArchivo );
  if encontrado then 
  Posicion:=posicionArchivo
  else
  Posicion:=-1;
end;

procedure altaEstancia (var registroE:T_estancia; var archiv: archivo);
var opcion:char;
i:Integer;
begin
WriteLn('¿desea cargar una estancia?');
ReadLn(opcion);
while (opcion <> 'n') do
  begin
  WriteLn('ingrese los datos de la estancia');
  CargarRegistroEstancia(registroE);
  i:=Posicion(registroE.nombreEstancia,archiv);
  if i= -1 then
  begin
    i:= FileSize(archiv); // nos da el tamaño del archivo
    seek (archiv,i);
    Write(archiv,registroE)
  end
  else
  WriteLn('ya existe una estancia con ese nombres. Los datos no fueron cargados');
  WriteLn('¿desea cargar una estancia?');
  ReadLn(opcion);
    end;

end;

procedure baja(var archiv:archivo; var estancia : T_estancia; posicionEstancia : integer);
var 
opcion : char;
begin

WriteLn('¿desea dar de baja una estancia?');
ReadLn(opcion);
  if (Upcase(opcion) <> 'N') then
  begin
   
    //Se posiciona en la estancia
    seek(archiv,posicionEstancia);
    //Lee la estancia
    Read(archiv,estancia);
    //Escribe el nombre a modo de prueba
    WriteLn('Se elimino la estancia ', estancia.nombreEstancia);
    
    //Si la estancia está activa
    if (estancia.alta) then
    begin
    //La da de baja
    estancia.alta:=False;
    //Escribe el archivo para guardar los cambios
    seek(archiv,posicionEstancia);//faltaba agregarle el seek para que se posicione y lo borre
    Write(archiv,estancia);        
    end
  else
  //Si la estancia ya estaba inactiva, avisa al usuario
  WriteLn('La estancia ingresada ya había sido dada de baja');
  end;
end;


procedure ConsultarEstancia (var estanciaE: T_estancia; var archiv:archivo);
var i:integer;
 n:String;
begin
WriteLn('ingrese el nombre de la estancia que desea consultar');
readln(n);
i:= Posicion(n,archiv);
  seek(archiv,i);
  read(archiv,estanciaE);
  writeln('Estancia alta: ', estanciaE.alta);
  if (estanciaE.alta) then
  mostrarEstancia(estanciaE)
    else
     WriteLn('la estancia no existe');
end;

procedure modificarEstancia(var archiv:archivo);
var E:String;
I:integer;
estancia:T_estancia;
begin
  WriteLn('instroduzca el nombre de la estancia que desea modificar');
  ReadLn(E);
  I:= Posicion (E,archiv);
  if I=-1 then
    WriteLn('no esxiste la estancia buscada')
    else
    begin
      seek(archiv,I);
      Read(archiv,estancia);
      if estancia.alta then // aca se utiliza un boleano para modificarlo, podemos ver si usamos el mismo o si generamos otro.
        begin
        WriteLn('introduzca nuevos datos de la estancia');
        CargarRegistroEstancia(estancia);
        I:= FilePos (archiv) -1;
        seek(archiv,I);
        Write(archiv,estancia);
        WriteLn('el registro ha sido modificado');
        end
      else
        WriteLn('el registro fue dado de baja');
      end;

end;


 procedure consultar(var archiv:archivo);
 var 
 estancia:T_estancia;
 N:String;
 i:Integer;
 begin
   WriteLn('que estancia desea consultar? ingrese su nombre');
   Read(N);
   i:= Posicion(N,archiv);
   if i= -1 then
     WriteLn('no existe la estancia que esta buscando')
     else
     seek(archiv,i);
     read(archiv,estancia);
     mostrarEstancia(estancia);
 end;

procedure incializarRegistroProvincia(var registroP:T_provincias);
begin
      with registroP do 
      begin
      Denominacion:=' ';
      cod_provincia:= 0;
      Telefono:=0;
        
      end;
end;

procedure CargarRegistroProvincia (var registroP:T_provincias);
begin

  with registroP do
    begin
     WriteLn('ingrese el nombre de la provincia');
     ReadLn(Denominacion);
     WriteLn('ingrese el codigo de la provincia');
     ReadLn(cod_provincia);
     WriteLn('ingrese el telefono del ministerios de turismo');
     ReadLn(telefono);
    end;
end;


function PosicionProvincia( N:String; var archivoP:archivo_Provincia):Integer;
var 
registroP:T_provincias;
encontrado:Boolean;
posicionArchivo : integer;

begin
  //Inicialización de variables
  encontrado:=false;
  posicionArchivo := 0;
  seek(archivoP, posicionArchivo);
  //Ciclo mientras NO sea el final del archivo y NO se haya encontrado
  while not Eof(archivoP) and not encontrado do 
  begin
    //Posicionamiento en el archivo
    seek(archivoP, posicionArchivo);
    
    //Lectura de la variable
    read(archivoP,registroP);

    //Comprobación: el nombreEstancia es igual al nombre ingresado?
    if registroP.Denominacion = N then
      encontrado:= true
    else 
      //Actualización para la próxima iteración
      posicionArchivo := posicionArchivo + 1;
  end;
WriteLn('encontrado ', encontrado );
WriteLn('posicion archivo ',posicionArchivo );
  if encontrado then 
  PosicionProvincia:=posicionArchivo
  else
  PosicionProvincia:=-1;
end;

procedure altaProvincia (var registroP:T_provincias; var archivoP: archivo_Provincia);
var opcion:char;
i:Integer;
begin
WriteLn('¿desea cargar una provincia?');
ReadLn(opcion);
while (opcion <> 'n') do
  begin
  WriteLn('ingrese los datos de la provincia');
  CargarRegistroProvincia(registroP);
  i:=PosicionProvincia(registroP.Denominacion,archivoP);
  if i= -1 then
  begin
    i:= FileSize(archivoP); // nos da el tamaño del archivo
    seek (archivoP,i);
    Write(archivoP,registroP)
  end
  else 
  WriteLn('ya existe una provincia con ese nombre. Los datos no fueron cargados');
   
  WriteLn('¿desea cargar otra provincia?');
  ReadLn(opcion);
    end;

end;

procedure LeerArchivo(var archiv:archivo; var v:T_vector; var lim:integer);
begin
  lim:=0;
  repeat 
  lim:= lim+1;
  Read(archiv,v[lim]);
  until Eof(archiv);
end;

procedure burbuja( var v:T_vector; lim: Integer);
    var i,j: Integer;
    aux:T_estancia;
begin
  for i := 1 to lim - 1 do 
    begin
      for j:= 1 to lim -i do 
        begin
          if v[j].nombreEstancia > v [j+1].nombreEstancia then 
            begin
              aux:= v [j];
              v[j]:= v [j+1];
              v[j+1]:= aux;
            end;
        end;      
    end;
end;

procedure ModificarArchivo(var archiv:archivo; var v:T_vector; var lim:Integer);  //modifica el archivo guardando los registros ordenados
var i:Integer;
begin
  Rewrite(archiv);//sobreescribe el archivo
  for i:= 1 to lim do 
  Write(archiv,v[i]);
end;

procedure listado (var archiv:archivo);
var estancia:T_estancia;
begin

reset(archiv);
 while not Eof(archiv) do
  begin
  
    WriteLn('Registro: ', FilePos(archiv) + 1);
    Read(archiv,estancia);
    
    if estancia.alta then
      mostrarEstancia(estancia)
      else
      WriteLn('el registro esta vacio');
  end;
end;

procedure listadoPiscinas( var archiv : archivo);
var estancia:T_estancia;
begin

reset(archiv);
 while not Eof(archiv) do
  begin
    WriteLn('');
    WriteLn('Listado de estancias que poseen piscina');
    WriteLn('Registro: ', FilePos(archiv) + 1);
    Read(archiv,estancia);
    
    if estancia.alta  AND estancia.tienePiscina then
      mostrarEstancia(estancia)
  end;
end;

Begin
End.