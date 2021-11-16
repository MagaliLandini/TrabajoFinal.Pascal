Program trabajofinal;
//le borré el Uses crt porque en mi compu siempre me da error (ni idea por qué)
type
// T_domicilio=record
//     calle:String;
//     numero:Integer;
//     piso:Integer;
//     ciudad:String;
//     cod_provincia:String;
//     codigoPostal:Integer;
//     end;
T_estancia=record
    ID_Estancia : integer;
    nombreEstancia:string;
    apellNomDueno:String;
    Dni:Integer;
    domicilio:String;
    numeroContacto:Integer;
    email:String;
    caracteristicas:String;
    tienePiscina:String;
    capacidadMaxima:Integer;
    alta:Boolean;
end;

archivo=file of T_estancia;
// procedure incializarRegistroDomicilio(registro:T_domicilio);
// begin
//       with registro do 
//       begin
//             calle:=' ';
//             numero:=' ';
//             piso:=0;
//             ciudad:=' ';
//             cod_provincia:= ' ';
//             codigoPostal:=0;
//           end;
// end;
// procedure CargarRegistroDomicilio (var registro:T_domicilio);
// begin
//   with registro do
//     begin
//       WriteLn('ingrese la calle del domicilio');
//       ReadLn(calle);
//       WriteLn('ingrese el numero del domicilio ');
//       ReadLn(numero);
//       WriteLn('ingrese el piso');
//       ReadLn(piso);
//       WriteLn('ingrese la ciudad');
//       ReadLn(ciudad);
//       WriteLn('ingrese el codigo de la provinvia');
//       ReadLn(cod_provincia);
//       WriteLn('ingrese el codigo postal');
//       ReadLn(codigoPostal);
            
            
//     end;
// end;

procedure incializarRegistro(var registroE:T_estancia; var contadorEstancias : integer);
begin
    contadorEstancias := contadorEstancias + 1;
      with registroE do 
      begin
        ID_Estancia:= contadorEstancias;
        nombreEstancia:=' ';
        apellNomDueno:=' ';
        Dni:=0;
        domicilio:= ' '; //incializarRegistroDomicilio(registroD); // se pude inicializar asi?
        numeroContacto:=0;
        email:='';
        caracteristicas:='';
        tienePiscina:='';
        capacidadMaxima:=0;
        alta:=true;
        
      end;
end;
procedure CargarRegistroEstancia (var registroE:T_estancia);

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
      //CargarRegistroDomicilio(registroD);  //ver si es asi como se usa registro de registro 
      ReadLn(domicilio);
      WriteLn('ingrese un numero de contacto');
      ReadLn(numeroContacto);
      WriteLn('ingrese su email');
      ReadLn(email);
      WriteLn('caracterice la estancia');
      ReadLn(caracteristicas);
      WriteLn('¿tiene piscina?');
      ReadLn(tienePiscina);
      WriteLn('capacidad maxima de la estancia');
      ReadLn(capacidadMaxima);
      alta := true;            
    end;
end;

procedure mostrarRegistro (estanciaE : T_estancia);
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
      //CargarRegistroDomicilio(registroD);  //ver si es asi como se usa registro de registro 
      writeln(domicilio);
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
var registro:T_estancia;
encontrado:Boolean;
begin
  encontrado:=false;
  seek(archiv,0);
  while not Eof(archiv) and not encontrado do 
  begin
    read(archiv,registro);
    encontrado:= registro.nombreEstancia=N
    end;
  if encontrado then 
  Posicion:= FilePos(archiv) -1
  else
  Posicion:=-1;
end;

procedure altaEstancia (var registroE:T_estancia; var archiv: archivo);
var opcion:char;
begin
WriteLn('¿desea cargar una estancia?');
ReadLn(opcion);
while (opcion <> 'n') do
  begin
  CargarRegistroEstancia(registroE);
  Write(archiv,registroE);
  WriteLn('¿desea cargar una estancia?');
  ReadLn(opcion);
    end;

end;

procedure baja(var estancia:T_estancia; var archiv:archivo; nombreE:String);
var 
opcion : char;
i:Integer;
begin
i:= Posicion(nombreE,archiv);

WriteLn('¿desea dar de baja una estancia?');
ReadLn(opcion);
  if (opcion <> 'n') then
  begin
  WriteLn('entro');
  seek(archiv,i);
    Read(archiv,estancia);
    WriteLn(estancia.nombreEstancia);
    if (estancia.alta) then
    begin
    estancia.alta:=False;
    // seek(archiv,i);
    // Read(archiv,estancia);
    Write(archiv,estancia);        
    end
  else
  WriteLn('La estancia ingresada ya fue dada de baja');
  end;
end;


procedure mostrarEstancia (var estanciaE: T_estancia; var archiv:archivo);
var posicion:integer;
begin
WriteLn('ingrese la posicion de la estancia');
read(posicion);
  seek(archiv,posicion);
  read(archiv,estanciaE);
  writeln('Estancia alta: ', estanciaE.alta);
  if (estanciaE.alta) then
  mostrarRegistro(estanciaE)
    else
     WriteLn('la estancia no existe');
end;



procedure listado (var registroE:T_estancia);
begin
  WriteLn(registroE.nombreEstancia);
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
    mostrarEstancia(estancia,archiv);
end;
var 
estancia:T_estancia; 
archivo1:archivo;
contadorEstancias : integer;
nombreEst:String;
//domicilio:T_domicilio;
begin
  Assign(archivo1,'D:\Documentos\Sistema\fundamentos de programacion\tp final\TrabajoFinal.Pascal-main/archivo1.dat');
  Reset(archivo1);
  //Seek(archivo1,0);
  // read(archivo1,estancia);
  incializarRegistro(estancia, contadorEstancias);
  altaEstancia(estancia,archivo1);
  mostrarEstancia(estancia,archivo1);
  WriteLn('ingrese el nombre de la estancia que desea dar de baja');
  ReadLn(nombreEst);
  baja(estancia,archivo1,nombreEst);
  // Write(archivo1,estancia);
 
  //WriteLn('estancia', estancia.nombreEstacia);
  // write(Read(archivo1,estancia));
 //listado(archivo1,estancia);
   close(archivo1);
end.