Program trabajofinal;
Uses Crt;
type
T_domicilio=record
    calle:String;
    numero:Integer;
    piso:Integer;
    ciudad:String;
    cod_provincia:String;
    codigoPostal:Integer;
    end;
T_estancia=record
    nombreEstacia:string;
    apellNomDueno:String;
    Dni:Integer;
    domicilio:domicilio;
    numeroContacto:Integer;
    email:String;
    caracteristicas:String;
    tienePiscina:String;
    capacidadMaxima:Integer;
end;

archivo=file of estancia;
procedure incializarRegistroDomicilio(registro:T_domicilio);
begin
      with registro do 
      begin
            calle:=' ';
            numero:=' ';
            piso:=0;
            ciudad:=' ';
            cod_provincia:= ' ';
            codigoPostal:=0;
          end;
end;
procedure CargarRegistroDomicilio (var registro:T_domicilio);
begin
  with registro do
    begin
      WriteLn('ingrese la calle del domicilio');
      ReadLn(calle);
      WriteLn('ingrese el numero del domicilio ');
      ReadLn(numero);
      WriteLn('ingrese el piso');
      ReadLn(piso);
      WriteLn('ingrese la ciudad');
      ReadLn(ciudad);
      WriteLn('ingrese el codigo de la provinvia');
      ReadLn(cod_provincia);
      WriteLn('ingrese el codigo postal');
      ReadLn(codigoPostal);
            
            
    end;
end;

procedure incializarRegistro(registroE:T_estancia; registroD:T_domicilio);
begin
      with registro do 
      begin
        nombreEstacia:=' ';
        apellNomDueno:=' ';
        Dni:=0;
        domicilio:=incializarRegistroDomicilio(registroD); // se pude inicializar asi?
        numeroContacto:=0;
        email:='';
        caracteristicas:='';
        tienePiscina:='';
        capacidadMaxima:=0;
          end;
end;
procedure CargarRegistroEstancia (var registroE:T_estancia; var registroD:T_domicilio);
begin
  with registro do
    begin
      WriteLn('ingrese el nombre de la estancia');
      ReadLn(nombreEstacia);
      WriteLn('ingrese el apellido y nombre del dueño ');
      ReadLn(apellNomDueno);
      WriteLn('ingrese el DNI');
      ReadLn(Dni);
      CargarRegistroDomicilio(registroD);  //ver si es asi como se usa registro de registro 
      ReadLn(domicilio);
      WriteLn('ingrese un numero de ocntacto');
      ReadLn(numeroContacto);
      WriteLn('ingrese su email');
      ReadLn(email);
      WriteLn('caracterice la estancia');
      ReadLn(caracteristica);
      WriteLn('¿tiene piscina?');
      ReadLn(tienePiscina);
      WriteLn('capacidad maxima de la estancia');
      ReadLn(capacidadMaxima);
            
    end;
end;
var estancia:T_estancia; 
domicilio:T_domicilio;
begin
  Assign(archivo,'D:\Documentos\Sistema\fundamentos de programacion\tp final\archivo1.dat');
  incializarRegistro(estancia,domicilio);
  CargarRegistroEstancia(estancia,domicilio);
  Write(archivo,estancia);
end.