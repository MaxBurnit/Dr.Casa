class UserException inherits Exception { }

class Persona{
	var property pin
	var property saldo = 0
	method abrirCuenta(pinNuevo){
		cajero.abrirCuenta(pinNuevo, self)
		pin = pinNuevo
		cajero.aniadirUsuario(self)
		}
	
	method consultarSaldo(pinUsu){
		cajero.verificarUsuario(pinUsu, self)
		return cajero.mostrarSaldo(self)
		}
	
	method depositarDinero(dinero){
		self.saldo(dinero)
		}
	method retirarDinero(pinUsu, cant){
		cajero.verificarUsuario(pinUsu, self)
		cajero.retirarDinero(self, cant)
	}
	
	method transferencia(pinUsu, cantidad, otroUsuario){
		cajero.verificarUsuario(pinUsu, self)
		cajero.estaRegistrado(otroUsuario)
		cajero.transferencia(cantidad, self, otroUsuario)
	}
}


object cajero{
	var property usuariosRegistrados = []
	method aniadirUsuario(usuario){
		usuariosRegistrados.add(usuario)
	}
	
	method abrirCuenta(pinNuevo, usuario){
		if(pinNuevo.size() < 4){
			throw new UserException("Inserte un pin con cuatro digitos")
		}
		if(pinNuevo.all({num => num == pinNuevo.first()})){
			throw new UserException("No inserte un pin con cuatro digitos iguales")
		}
		if(pinNuevo == pinNuevo.sortedBy{a, b => a < b}){
			throw new UserException("No inserte un pin con cuatro digitos en orden ascendente")
		}
		if(usuariosRegistrados.contains(usuario)){
			throw new UserException("Usuario ya registrado")
		}
		
	}
	
	method estaRegistrado(usuario){
		if(!usuariosRegistrados.contains(usuario)){
			throw new UserException("El usuario no esta registrado")
		}
	}
	method verificarUsuario(pinUsuario, usuario){
		if(usuario.pin() != pinUsuario){
			throw new UserException("Pin incorrecto")
			}
	}
	
	method mostrarSaldo(usuario){
		return usuario.saldo()
	}
	
	method retirarDinero(usuario, cantidad){
		if(usuario.saldo() < cantidad){
			throw new UserException("Saldo insuficiente")
		}
		usuario.saldo(usuario.saldo() - cantidad)
	}
	
	
	method transferencia(cantidad, usuario1, usuario2){
		self.retirarDinero(usuario1, cantidad)
		usuario2.depositarDinero(cantidad)
	}
	
}
