Program trabajofinal;
uses unit_estancias;

var 
estancia:T_estancia; 
archivo1:archivo;
archivo_p:archivo_Provincia;
posicionEstancia, opcionMenu,lim, opcionListados : integer;
nombreEst:String;
vectorEstancia:T_vector;
provincia:T_provincias;


begin
  Assign(archivo1,'./archivo1.dat');
  Assign(archivo_p,'./archivoProv.dat');
  Reset(archivo1);
  Reset(archivo_p);

  //MENÚ
  WriteLn('----- Sistema de Gestión de Estancias Turísiticas -----');
  WriteLn('¿Qué acción desea realizar?');
  Writeln('');
  WriteLn('ESTANCIAS: ');
  WriteLn('1. Consultar una estancia');
  WriteLn('2. Dar de alta una estancia');
  WriteLn('3. Dar de baja una estancia');
  WriteLn('4. Modificar una estancia');
  WriteLn('5. Listar Estancias');
  WriteLn('6. Dar de alta una provincia');
  Writeln('');
  WriteLn('PROVINCIAS: ');
  //opciones ABMC provincias
  Writeln('');
  WriteLn('LISTADOS: ');
  //opciones listados de estancias y de provincias
  Writeln('');
  WriteLn('0. Salir ');
  ReadLn(opcionMenu);

  case (opcionMenu) of
    0: close(archivo1);
    1: consultar(archivo1);
    2: begin
       incializarRegistro(estancia); 
       altaEstancia(estancia,archivo1);
       end;
    3:  begin
        WriteLn('ingrese el nombre de la estancia que desea dar de baja: ');
        Readln(nombreEst); 
        posicionEstancia := Posicion(nombreEst, archivo1);
         if (posicionEstancia > -1) then
          baja(archivo1, estancia, posicionEstancia);
           // baja(archivo1, estancia, posicionEstancia);
        end;
    4: modificarEstancia(archivo1);
    5:  begin 
         WriteLn('¿Qué acción desea realizar?');
         WriteLn('1. Listar estancias');
         WriteLn('2. listado de estancias por provincias');
         WriteLn('3. estancias que poseen piscinas');
         ReadLn(opcionListados);
         case (opcionListados) of
          1: begin
              LeerArchivo(archivo1,vectorEstancia,lim);
              burbuja(vectorEstancia,lim);
              ModificarArchivo(archivo1,vectorEstancia,lim);
              listado(archivo1);
              end;
            2: WriteLn('listado de provincias');
            3: WriteLn('poseen piscinas');
          end;
          end;
    6: begin
        incializarRegistroProvincia(provincia);
        altaProvincia(provincia,archivo_p);
      end;
    else WriteLn('No se reconoce la operación ingresada');
    end;

  //Seek(archivo1,0);
  // read(archivo1,estancia);
  // incializarRegistro(estancia);
  // altaEstancia(estancia,archivo1);
  
  
  // //PRUEBA BAJA
  // //Qué estancia se dará de baja?
  // WriteLn('ingrese el nombre de la estancia que desea dar de baja: ');
  // Readln(nombreEst);
  // //Posición de la estancia a dar de baja
  // posicionEstancia := Posicion(nombreEst, archivo1);
  // //Muesta la posición (PRUEBA) (por ahora sólo me devuelve -1)
  // WriteLn('Posición de la estancia buscada: ', posicionEstancia);
  // //SÓLO SI la estancia fue encontada, se llama al procedimiento baja
  // if (posicionEstancia > -1) then
  //   baja(archivo1, estancia, posicionEstancia);

  // modificarEstancia(archivo1);
  // ConsultarEstancia(estancia,archivo1);

  // LeerArchivo(archivo1,vectorEstancia,lim);
  // burbuja(vectorEstancia,lim);
  // ModificarArchivo(archivo1,vectorEstancia,lim);
  

  // Write(archivo1,estancia);
 
  //WriteLn('estancia', estancia.nombreEstacia);
  // write(Read(archivo1,estancia));
 //listado(archivo1,estancia);
   close(archivo1);
   close(archivo_p);
end.