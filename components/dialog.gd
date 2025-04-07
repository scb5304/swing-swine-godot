extends Window

signal positive_button_clicked
signal negative_button_clicked

func _on_positive_button_pressed():
	visible = false
	positive_button_clicked.emit()

func _on_negative_button_pressed():
	visible = false
	negative_button_clicked.emit()
