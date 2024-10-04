extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sc = ScrollContainer.new()
	sc.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	var label = RichTextLabel.new()
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("normal_font_size", 32)
	
	var file = FileAccess.open("res://LICENSE.txt", FileAccess.READ)
	var content = file.get_as_text()
	
	label.text = content
	
	file = FileAccess.open("res://GODOT_COPYRIGHT.txt", FileAccess.READ)
	content = file.get_as_text()
	
	label.text += "\n\n" + content
	
	sc.add_child(label)

	add_child(sc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
