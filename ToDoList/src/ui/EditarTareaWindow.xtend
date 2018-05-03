package ui

import model.Tarea
import model.TareaAppModel
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarTareaWindow extends TransactionalDialog<TareaAppModel> {

	new(WindowOwner owner, Tarea model) {
		super(owner, createViewModel(model))
		title = "Editar Tarea"
	}

	static def createViewModel(Tarea tarea) {
		val model = new TareaAppModel()
		model.tareaSeleccionada = tarea
		return model
	}

	override protected createFormPanel(Panel mainPanel) {
		val panel1 = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new TextBox(panel1) => [
			value <=> "tareaSeleccionada.descripcion"
		]

		new CheckBox(panel1) => [
			value <=> "tareaSeleccionada.hecho"
		]
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [this.accept]
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [this.cancel]
		]
	}
}
