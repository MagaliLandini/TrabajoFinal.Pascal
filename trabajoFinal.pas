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

procedure incializarRegistro(registroE:T_estancia);
begin
      with registroE do 
      begin
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
      WriteLn('ingrese un numero de ocntacto');
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
procedure baja(var estancia:T_estancia; var archiv:archivo; posicion:integer);
begin
  estancia.alta:=False;
  seek(archiv,posicion);
  Write(archiv,estancia);
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


var estancia:T_estancia; 
archivo1:archivo;
//domicilio:T_domicilio;
begin
  Assign(archivo1,'./archivo1.dat');
  Reset(archivo1);
  //Seek(archivo1,0);
  // read(archivo1,estancia);
  incializarRegistro(estancia);
  altaEstancia(estancia,archivo1);
  mostrarEstancia(estancia,archivo1);
  // Write(archivo1,estancia);
 
  //WriteLn('estancia', estancia.nombreEstacia);
  // write(Read(archivo1,estancia));
 //listado(archivo1,estancia);
   close(archivo1);
end.