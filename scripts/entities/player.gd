extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var current_camera_perspective = 1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * Settings.mouse_sensitivity))
		
		if current_camera_perspective == 1:
			$Camera.rotate_x(deg_to_rad(-event.relative.y * Settings.mouse_sensitivity))
			$Camera.rotation.x = clamp($Camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		else:
			$ThirdPersonCameraSpring.rotate_x(deg_to_rad(-event.relative.y * Settings.mouse_sensitivity))
			$ThirdPersonCameraSpring.rotation.x = clamp($ThirdPersonCameraSpring.rotation.x, deg_to_rad(-20), deg_to_rad(40))
	
	if event.is_action_pressed("unfocus_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("switch_perspective"):
		if current_camera_perspective == 1:
			current_camera_perspective = 3	
			
			$Camera.current = false
			$ThirdPersonCameraSpring/Camera3D.current = true
		else:
			current_camera_perspective = 1
			
			$ThirdPersonCameraSpring/Camera3D.current = false
			$Camera.current = true
	
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
