import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class Tarea {

	String descripcion = ""
	Boolean hecho = false
	String descripcionEditable

	new(String descripcion) {
		this.descripcion = descripcion
	}

	new() {
	}

	def cambiarEstado() {
		hecho = !hecho
	}

	def editarDescripcion() {
		descripcion = descripcionEditable
	}
}
