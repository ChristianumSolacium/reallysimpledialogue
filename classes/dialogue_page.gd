@tool
extends Resource
class_name DialoguePage

signal text_changed(text:String)


@export_multiline var text : String :
	set(value):
		text = value
		if Engine.is_editor_hint():
			text_changed.emit(text)
