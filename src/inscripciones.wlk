class Materia{
	var property carrera
	const property curso = #{}
	const creditosQueOtorga = 0
	const anio = 0
	const cupo = 0
	const property listaDeEspera = #{}
	method inscribir(estudiante){
		if(estudiante.puedeCursar(self)){
			if(self.hayCupo()){
				curso.add(estudiante)
			}else{
				listaDeEspera.add(estudiante)
			}
		}else{
			self.error("El estudiante no puede cursar esta materia")
		}
	}
	method darDeBaja(estudiante){//
		curso.remove(estudiante)
		if(not listaDeEspera.isEmpty()){
			curso.add(listaDeEspera.first())
			listaDeEspera.remove(listaDeEspera.first())
		}
	}
	method hayCupo() = curso.size() < cupo
	method estudiantesInscriptos() = curso
	method estudiantesEnListaDeEspera() = listaDeEspera
}

class MateriaQueMiraCorrelativas inherits Materia {
	const correlativas = #{}
	method cumplePrerrequisito(estudiante) = estudiante.aproboMaterias(correlativas)
	method agregarCorrelativa(materia){
		correlativas.add(materia)
	}
}

class MateriaQueMiraCreditos inherits Materia {
	const creditosRequeridos = 0
	method cumplePrerrequisito(estudiante) = estudiante.creditos() >= creditosRequeridos 
}

class MateriaQueMiraMateriasDelAnioAnterior inherits Materia {
	method cumplePrerrequisito(estudiante) = estudiante.aproboMaterias(self.materiasDelAnioAnterior(carrera))
	method materiasDelAnioAnterior(carrera) = carrera.materiasDelAnio(anio - 1)
}

class MateriaQueNoMira inherits Materia {
	method cumplePrerrequisito(estudiante) = true
}

class MateriaAprobada{
	var property materia
	var property nota
}

class Carrera{
	const property materias = #{}
	method materiasDelAnio(anio) = materias.filter { materia => materia.anio() == anio }
	method agregarMateria(materia){ materias.add(materia) }
}

class Estudiante{
	const carreras = #{}
	const materiasAprobadas = #{}
	var property creditos = 0
	method agregarCarrera(carrera){ carreras.add(carrera) }
	method puedeCursar(materia) = self.esDeSusCarreras(materia) and not self.aprobo(materia) and 
								  not self.estaInscripto(materia) and materia.cumplePrerrequisito(self)
	method aprobo(materia) = materiasAprobadas.any { materiaAprobada => materiaAprobada.materia() == materia }
	method aproboMaterias(materias) = materias.all { materia => self.aprobo(materias) }
	method estaInscripto(materia) = materia.curso().contains(self)
	method esDeSusCarreras(materia) = carreras.contains(materia.carrera())
	method aprobarMateria(materia, nota){
		materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
	}
	method materiasALasQueSePuedeInscribir(carrera) = if(carreras.contains(carrera)) carrera.materias().filter { materia => self.puedeCursar(materia) }
													  else #{}
	method materiasALasQueEstaInscripto() = carreras.flatMap { carrera => 
																	carrera.materias().filter { materia => self.estaInscripto(materia) }
														  }.asSet()
	method materiasEnLasQueEstaEnListaDeEspera() = carreras.flatMap { carrera => 
																	carrera.materias().filter { materia => self.estaEnListaDeEspera(materia) }
														  }.asSet()
	method estaEnListaDeEspera(materia) = materia.listaDeEspera().contains(self)

}