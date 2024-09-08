@tool
extends RichTextLabel
class_name DialogueLabel

signal changed_page
signal reached_end

var current_page_index := 0

@export var dialogue_pages: DialoguePageContainer:
	set(value):
		dialogue_pages = value
		if Engine.is_editor_hint():
			dialogue_pages.update_text.connect(func(text_to_show:String): text = text_to_show)
# TODO implement @export var typing_speed: float


func _ready() -> void:
	go_to_page(0)
	if not Engine.is_editor_hint():
		set_process(false)


func go_to_page(dialogue_page_index:int) -> void:
	if dialogue_pages == null:
		push_warning("dialogue_pages not defined")
		return
	text = dialogue_pages.pages[dialogue_page_index].text
	current_page_index = dialogue_page_index
	changed_page.emit()


func next_page(cycle := true) -> void:
	current_page_index += 1
	if (current_page_index == len(dialogue_pages.pages)
			or dialogue_pages.pages[current_page_index] == null):
		reached_end.emit()
		if cycle:
			current_page_index = 0
		else:
			return
	text = dialogue_pages.pages[current_page_index].text
	changed_page.emit()
