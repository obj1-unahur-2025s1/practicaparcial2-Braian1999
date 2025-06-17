class Personaje { // clase axtracta
    const fuerza
    const inteligencia
    var rol
    
    method cambiarRol(unRol) {rol = unRol}
    method potencialOfensivo() {
        return fuerza * 10 + rol.extra()
    }
    method esGroso() = self.esInteligente() || self.esGrosoEnSuRol()
    method esInteligente()
    method esGrosoEnSuRol() = rol.esGroso(self)
}

//personajes
class Orco inherits Personaje {
    override method potencialOfensivo() {
        return if(rol == brujo) super() * 1.1 else super()
    }
    override method esInteligente() = false
}

class Humano inherits Personaje {
    override method esInteligente() = inteligencia > 50
}

// roles
object cuerrero {
    method extra() = 100
    method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
}
class Cazador {
    const property mascota

    method extra() = mascota.extra()
    method esGroso(unPersonaje) = mascota.esLongeva() 
}
class Mascota {
    const property fuerza
    const property tieneGarras
    var edad

    method extra() = if(tieneGarras) fuerza *2 else  fuerza
    method esLongeva() = edad > 10
}
object brujo {
    method extra() = 0
    method esGroso(unPersonaje) = true
}

// LOCALIDADES
class Localidad {
    var ejercito
    method ejercito() = ejercito
    method poderDefensivo() = ejercito.poderOfencivo()  
}

class Aldea inherits Localidad{
    const cantidadMaximaHabiantes

    method serOcupada(unEjercito) {
        if(unEjercito.size() > cantidadMaximaHabiantes) // Error
        ejercito = unEjercito.ejercitoMasFuerte()
    }  
}

class Ciudad  inherits Localidad{
    override method poderDefensivo() = super() + 300
    method serOcupada(unEjercito) {
        ejercito = unEjercito
    }  
}

class Ejercito {
    const Personajes = []

    method invadir(unaLocalidad) {
        if(self.puedeTomarLocalidad(unaLocalidad)){
            unaLocalidad.serOcupada(self)
        }
    }
    method poderOfensivo() = Personajes.sum({p=>p.potencialOfensivo()})
    method puedeTomarLocalidad(unaLocalidad) = self.poderOfensivo() > unaLocalidad.poderDefensivo()
    method ejercitoMasFuerte() = self.ordenadosLosMasPoderosos().take(10)
    method ordenadosLosMasPoderosos() = Personajes.sortBy({p1,p2=> p1.potencialOfensivo() > p2.potencialOfensivo()})
    
}


// Apuntes del profe
// https://github.com/obj1-unahur-2025s1/PresentacionPersonal-hernanianigro