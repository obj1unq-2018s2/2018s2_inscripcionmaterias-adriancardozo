class Materia {

	var property carrera
	const curso = #{}
	// TODO ¿Esto no se usa?
	const creditosQueOtorga = 0
	// TODO ¿Esto no se usa?
	const anio = 0
	var property cupo = 0
	const listaDeEspera = #{}

	method inscribir(estudiante, criterioInscripcion) {
		// TODO Muchas veces más fácil si descartás primero los casos malos, se evita el anidamiento.
		if (!estudiante.puedeCursar(self)) {
			self.error("El estudiante no puede cursar esta materia")
		} else if (criterioInscripcion.criterio(self, estudiante)) {
			// TODO Acá el mensaje "criterio" es muy poco descriptivo 
			// Y "curso" como nombre de atributo, también
			curso.add(estudiante)
		} else {
			listaDeEspera.add(estudiante)
		}
	}

	method darDeBaja(estudiante) { //
		curso.remove(estudiante)
		if (not listaDeEspera.isEmpty()) {
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

	method agregarCorrelativa(materia) {
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

