class Carrera{
	const property materias = #{}
	method materiasDelAnio(anio) = materias.filter { materia => materia.anio() == anio }
	method agregarMateria(materia){ materias.add(materia) }
}
