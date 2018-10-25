object porOrdenLlegada{
	method criterio(materia, estudiante) = materia.hayCupo()
}

object elitista{
	method criterio(materia, estudiante) = materia.hayCupo() and (estudiante.promedio() > 9)
}

object porGradoAvance{
	method criterio(materia, estudiante) = materia.hayCupo() and (estudiante.materiasAprobadas().size() > 20)
}

