@tool
extends Resource
class_name DialoguePageContainer


signal update_text(text:String)

## se modifichi una delle DialoguePage mentre sei in editor mode, ti mostra le
## modifiche a schermo
@export var pages : Array[DialoguePage]:
	set(value):
		pages = value
		if Engine.is_editor_hint():
			for page in pages:
				if page != null and not page.text_changed.is_connected(_do_update_text):
					page.text_changed.connect(_do_update_text)


func _do_update_text(text:String):
	update_text.emit(text)
