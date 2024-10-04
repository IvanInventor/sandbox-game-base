extends Node

var mouse_sensitivity: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_settings()

func load_settings() -> void:
	var conf = ConfigFile.new()
	
	var err = conf.load("user://settings.cfg")
	
	if err != OK:
		print("[Settings] Error loading settings.cfg: " + error_string(err))
		return
	
	mouse_sensitivity = conf.get_value("input", "mouse_sensitivity")

func apply_settings() -> void:
	# Here i would do stuff like applying settings like max fps, AA, and stuff
	pass

func save_settings() -> void:
	var conf = ConfigFile.new()
	
	conf.set_value("input", "mouse_sensitivity", mouse_sensitivity)
	
	conf.save("user://settings.cfg")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
