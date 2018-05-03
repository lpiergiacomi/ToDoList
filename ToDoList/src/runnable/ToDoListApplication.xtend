package runnable

import org.uqbar.arena.Application
import ui.PantallaPrincipalWindow

class ToDoListApplication extends Application {

	override createMainWindow() {
		new PantallaPrincipalWindow(this)
	}

	def static main(String[] args) {
		new ToDoListApplication().start
	}
}
