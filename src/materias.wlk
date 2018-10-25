class Materia{
	var property carrera
	const curso = #{}
	const creditosQueOtorga = 0
	const anio = 0
	var property cupo = 0
	const listaDeEspera = #{}
	method inscribir(estudiante, criterioInscripcion){
		if(estudiante.puedeCursar(self)){
			if(criterioInscripcion.criterio(self, estudiante)){
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
	method estudiantesInscriptos() = curso.copy()
	method estudiantesEnListaDeEspera() = listaDeEspera.copy()
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

