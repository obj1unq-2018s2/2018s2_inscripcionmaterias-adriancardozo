class Estudiante {

	const carreras = #{}
	const materiasAprobadas = #{}
	
	// TODO Los créditos deberían calcularse a partir de las materias aprobadas.
	var property creditos = 0

	method agregarCarrera(carrera) {
		carreras.add(carrera)
	}

	method puedeCursar(materia) = self.esDeSusCarreras(materia) and not self.aprobo(materia) and not self.estaInscripto(materia) and materia.cumplePrerrequisito(self)

	method aprobo(materia) = materiasAprobadas.any{ materiaAprobada => materiaAprobada.materia() == materia }

	method aproboMaterias(materias) = materias.all{ materia => self.aprobo(materia) }

	// TODO Podría preguntarle directamente a la materia si estoy inscripto, en lugar de pedirle toda la lista de inscriptos
	method estaInscripto(materia) = materia.estudiantesInscriptos().contains(self)

	method esDeSusCarreras(materia) = carreras.contains(materia.carrera())

	method aprobarMateria(materia, nota) {
		// TODO Falta la validación que pide el enunciado
		materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
	}

	method materiasALasQueSePuedeInscribir(carrera) = if (carreras.contains(carrera)) carrera.materias().filter{ materia => self.puedeCursar(materia) } else #{}

	method materiasALasQueEstaInscripto() = carreras.flatMap{ carrera => carrera.materias().filter{ materia => self.estaInscripto(materia)} }.asSet()

	method materiasEnLasQueEstaEnListaDeEspera() = carreras.flatMap{ carrera => carrera.materias().filter{ materia => self.estaEnListaDeEspera(materia)} }.asSet()

	// TODO Podría preguntarle directamente a la materia, en lugar de pedirle toda la lista de espera
	method estaEnListaDeEspera(materia) = materia.estudiantesEnListaDeEspera().contains(self)

	method materiasAprobadas() = materiasAprobadas.copy()

	method promedio() = if (materiasAprobadas.size() > 0) materiasAprobadas.sum{ materiaAprobada => materiaAprobada.nota() } / materiasAprobadas.size() else 0

}

class MateriaAprobada {

	var property materia
	var property nota

}

