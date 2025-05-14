extends Control

signal positive_button_clicked
signal negative_button_clicked

func _on_positive_button_pressed():
	get_parent().remove_child(self)
	positive_button_clicked.emit()

func _on_negative_button_pressed():
	get_parent().remove_child(self)
	negative_button_clicked.emit()

func show_dialog(title: String, message: String, icon: String, positive: String, negative: String):
	print(title + ": " + message)
	$DialogWindow/DialogPanel/Title.text = title
	$DialogWindow/DialogPanel/Message.text = message
	$DialogWindow/DialogPanel/Icon.texture = load(icon)
	$DialogWindow/DialogPanel/PositiveButton.text = positive
	$DialogWindow/DialogPanel/NegativeButton.text = negative
	$DialogWindow.popup_centered()
