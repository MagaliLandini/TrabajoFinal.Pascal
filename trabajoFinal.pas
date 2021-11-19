Program trabajofinal;

type
T_estancia=record
    ID_Estancia : integer;
    nombreEstancia:string;
    apellNomDueno:String;
    Dni:Integer;
    domicilio:String;
    cod_provincia: string;
    numeroContacto:Integer;
    email:String;
    caracteristicas:String;
    tienePiscina:Boolean;
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
        cod_provincia:= ' ';
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
      Writeln('Código de provincia:');
      WriteLn(cod_provincia);
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
      WriteLn('alta');
      writeln(alta);
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
  end;
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

// procedure consultar(var archiv:archivo);
// var 
// estancia:T_estancia;
// N:String;
// i:Integer;
// begin
//   WriteLn('que estancia desea consultar? ingrese su nombre');
//   Read(N);
//   i:= Posicion(N,archiv);
//   if i= -1 then
//     WriteLn('no existe la estancia que esta buscando')
//     else
//     seek(archiv,i);
//     read(archiv,estancia);
//     mostrarEstancia(estancia,archiv);
// end;





var 
estancia:T_estancia; 
archivo1:archivo;
contadorEstancias, posicionEstancia : integer;
nombreEst:String;

begin
  Assign(archivo1,'./archivo1.dat');
  Reset(archivo1);
  //Seek(archivo1,0);
  // read(archivo1,estancia);
  incializarRegistro(estancia);
  altaEstancia(estancia,archivo1);
  
  
  //PRUEBA BAJA
  //Qué estancia se dará de baja?
  WriteLn('ingrese el nombre de la estancia que desea dar de baja: ');
  Readln(nombreEst);
  //Posición de la estancia a dar de baja
  posicionEstancia := Posicion(nombreEst, archivo1);
  //Muesta la posición (PRUEBA) (por ahora sólo me devuelve -1)
  WriteLn('Posición de la estancia buscada: ', posicionEstancia);
  //SÓLO SI la estancia fue encontada, se llama al procedimiento baja
  if (posicionEstancia > -1) then
    baja(archivo1, estancia, posicionEstancia);

  modificarEstancia(archivo1);
  ConsultarEstancia(estancia,archivo1);



  // Write(archivo1,estancia);
 
  //WriteLn('estancia', estancia.nombreEstacia);
  // write(Read(archivo1,estancia));
 //listado(archivo1,estancia);
   close(archivo1);
end.