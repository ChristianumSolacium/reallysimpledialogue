extends Button

@export var dialogue_label : DialogueLabel
func _on_pressed() -> void:
	dialogue_label.next_page()
