library my_prj.globals;

datosCliente? clienteLogeado;



class datosCliente
{
  String cedula = "";
  String nombre = "";
  String apellido = "";
  String correo = "";
  String celular = "";
  String contrasena = "";
  String direccion = "";

  datosCliente(cedula, nombre, apellido, correo, celular, direccion, contrasena)
  {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.cedula = cedula;
    this.celular = celular;
    this.contrasena = contrasena;
    this.direccion = direccion;
  }
}

