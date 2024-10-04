extends Node

var install_dir = OS.get_executable_path().get_base_dir()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(install_dir + "/GODOT_COPYRIGHT.txt"):
		print("[General] Creating GODOT_COPYRIGHT.TXT at " + install_dir + "/GODOT_COPYRIGHT.txt")
		var file = FileAccess.open(install_dir + "/GODOT_COPYRIGHT.txt", FileAccess.WRITE)
		var file_res = FileAccess.open("res://GODOT_COPYRIGHT.txt", FileAccess.READ)
		
		file.store_string(file_res.get_as_text())
