unit unit_archivos;
INTERFACE 
const n=1000;

type
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

T_vector= array [1..n] of T_estancia;
archivo=file of T_estancia;

procedure LeerArchivo(var archiv:archivo; var v:T_vector; var lim:integer);
procedure ModificarArchivo(var archiv:archivo; var v:T_vector; var lim:Integer);  //modifica el archivo guardando los registros ordenados
procedure listado (var archiv:archivo);


IMPLEMENTATION 

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

begin
end.