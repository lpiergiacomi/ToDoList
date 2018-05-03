package ui

import model.Tarea
import model.TareaAppModel
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PantallaPrincipalWindow extends SimpleWindow<TareaAppModel> {

	new(WindowOwner parent) {
		super(parent, new TareaAppModel)
	}

	override protected createFormPanel(Panel mainPanel) {
		
		val elementSelected = new NotNullObservable("tareaSeleccionada")
		
		title = "TODO List"
		val panel = new Panel(mainPanel)
		panel.layout = new ColumnLayout(2)

		new TextBox(panel) => [
			value <=> "exampleTarea.descripcion"
		]

		new Button(panel) => [
			caption = "Agregar Tarea"
			onClick[this.agregarTarea]
			setAsDefault
		]

		new TextBox(panel) => [
			value <=> "tareaSeleccionada.descripcionEditable"
		]

		new Button(panel) => [
			caption = "Editar Tarea"
			onClick[this.editarTarea]
			setAsDefault
			bindEnabled(elementSelected)
		]

		var tabla = new Table<Tarea>(mainPanel, Tarea) => [
			items <=> "resultadosTareas"
			value <=> "tareaSeleccionada"
			numberVisibleRows = 3
		]

		new Column<Tarea>(tabla) => [
			title = "Tarea"
			bindContentsToProperty("descripcion")
			fixedSize = 120
		]

		new Column<Tarea>(tabla) => [
			title = "Hecho"
			bindContentsToProperty("hecho").transformer = [ Boolean recibe |
				if(recibe) "SI" else "NO"
			]
			fixedSize = 120
		]
		
		val panel2 = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]

		new Button(panel2) => [
			caption = "Hacer/Deshacer"
			onClick[modelObject.tareaSeleccionada.cambiarEstado]
			bindEnabled(elementSelected)		
		]
		new Button(panel2) => [
			caption = "Editar"
			onClick[this.editarTarea2]
			bindEnabled(elementSelected)
		]
		

	}

	override protected addActions(Panel actionsPanel) {
	}

	def agregarTarea() {
		modelObject.agregarTarea(modelObject.exampleTarea)
	}

	def editarTarea() {
		modelObject.tareaSeleccionada.editarDescripcion
	}
	
	def editarTarea2() {
		val tarea = modelObject.tareaSeleccionada
		new EditarTareaWindow(this, tarea) => [
			open
		]
	}
}
