class_name PlayerController
extends CharacterBody3D

signal jumped
signal start_moving
signal stop_moving

@onready var neck: Node3D = $Neck
@onready var head: Node3D = $Neck/Head
@onready var eyes: Node3D = $Neck/Head/Eyes
@onready var standing_collision_shape: CollisionShape3D = $StandingCollisionShape
@onready var crouching_collision_shape: CollisionShape3D = $CrouchingCollisionShape
@onready var crouching_raycast: RayCast3D = $CrouchingRayCast
@onready var pcamera: PhantomCamera3D = %PlayerCamera

@export var data: PlayerControllerData
@export var enable_jumping: bool = false;
@export var enable_free_look: bool = false;
@export var enable_head_bobbing: bool = false;
@export var always_sprinting: bool = false;
@export var toggle_sprint: bool = true;

var gravity: Variant = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed_multiplier: float = 1.0
var current_speed: float

var input_dir := Vector2.ZERO
var slide_dir := Vector3.ZERO;
var current_move_dir := Vector3.ZERO

var walking: bool = false;
var sprinting: bool = false;
var crouching: bool = false;
var sliding: bool = false;
var free_looking: bool = false;

var slide_timer: float = 0.0
var slide_duration: float = 1.0

var head_bobbing_current_intensity: float = 0.0
var head_bobbing_dir : = Vector2.ZERO
var head_bobbing_index: float = 0.0

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	InputActionMapManager.mouse_motion_event.connect(_handle_mouse_motion)

func _physics_process(delta: float) -> void:
	handle_input()
	if InputActionMapManager.is_action_pressed("crouch"): # || sliding:
		handle_crouching(delta)
	elif !crouching_raycast.is_colliding():
		handle_standing(delta)
	handle_free_looking(delta)
	handle_sliding(delta)
	handle_head_bobbing(delta)
	handle_gravity(delta)
	if enable_jumping:
		handle_jump()
	handle_movement(delta)
	move_and_slide()

func _handle_mouse_motion(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		if free_looking:
			neck.rotate_y(deg_to_rad(-motion.relative.x) * data.mouse_sensitivity)
			neck.rotation.y = clamp(
				neck.rotation.y,
				deg_to_rad(-data.free_look_angle),
				deg_to_rad(data.free_look_angle))
		else:
			rotate_y(deg_to_rad(-motion.relative.x) * data.mouse_sensitivity)
			head.rotate_x(deg_to_rad(-motion.relative.y) * data.mouse_sensitivity)
			head.rotation.x = clamp(
				head.rotation.x, 
				deg_to_rad(data.vertical_look_min_angle), 
				deg_to_rad(data.vertical_look_max_angle))

func handle_crouching(delta: float) -> void:
	current_speed = data.crouching_speed
	head.position.y = lerp(head.position.y, data.crouching_height, delta * data.height_lerp_speed)
	standing_collision_shape.disabled = true;
	crouching_collision_shape.disabled = false;
	if sprinting && is_on_floor() && input_dir != Vector2.ZERO:
		on_slide_begin()
	crouching = true;
	walking = false;
	sprinting = false;

func on_slide_begin() -> void:
	sliding = true
	slide_timer = slide_duration
	slide_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if enable_free_look:
		free_looking = true

func on_slide_end() -> void:
	sliding = false
	free_looking = false

func handle_standing(delta: float) -> void:
	head.position.y = lerp(head.position.y, 0.0, delta * data.height_lerp_speed)
	crouching_collision_shape.disabled = true;
	standing_collision_shape.disabled = false;
	if sliding:
		on_slide_end()
	if always_sprinting:
		sprinting = true
	elif input_dir == Vector2.ZERO: # cancel sprinting if player stops
		sprinting = false
	elif InputActionMapManager.is_action_just_pressed("sprint"):
		sprinting = !sprinting;
	if sprinting:
		current_speed = data.sprinting_speed
		sprinting = true;
		walking = false;
		crouching = false;
	else:
		current_speed = data.walking_speed
		walking = true;
		sprinting = false;
		crouching = false;

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * data.weight_scale * delta

func handle_jump() -> void:
	if InputActionMapManager.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = data.jump_velocity
		sliding = false
		jumped.emit()

func handle_movement(delta: float) -> void:
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if sliding:
		current_move_dir = slide_dir
	else:
		current_move_dir = lerp(current_move_dir, move_dir, delta * data.decceleration)
	if current_move_dir:
		velocity.x = current_move_dir.x * current_speed * speed_multiplier
		velocity.z = current_move_dir.z * current_speed * speed_multiplier
		if sliding:
			# todo: Make a proper sliding decceleration system
			# Right now we add to the timer to keep some momentum at the end of the slide
			# but it causes the slide to end more abruptly if we stop moving during sliding
			var time := slide_timer + 0.15 
			velocity.x = current_move_dir.x * time * data.sliding_speed * speed_multiplier
			velocity.z = current_move_dir.z * time * data.sliding_speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed * speed_multiplier)
		velocity.z = move_toward(velocity.z, 0, current_speed * speed_multiplier)

func handle_free_looking(delta: float) -> void:
	if (InputActionMapManager.is_action_pressed("free_look") || sliding) && enable_free_look:
		free_looking = true
		pcamera.rotation.z = -deg_to_rad(neck.rotation.y * data.free_look_tilt_amount)
	else:
		free_looking = false
		neck.rotation.y = lerp(neck.rotation.y, 0.0, delta * data.free_look_snap_lerp_speed)
		pcamera.rotation.z = lerp(pcamera.rotation.y, 0.0, delta * data.free_look_snap_lerp_speed)

func handle_sliding(delta: float) -> void:
	slide_timer -= delta;
	if slide_timer <= 0:
		on_slide_end()

func handle_head_bobbing(delta: float) -> void:
	if !enable_head_bobbing:
		return
	if sprinting:
		head_bobbing_current_intensity = data.head_bobbing_sprinting_intensity
		head_bobbing_index += data.head_bobbing_sprinting_speed * delta
	elif walking:
		head_bobbing_current_intensity = data.head_bobbing_walking_intensity
		head_bobbing_index += data.head_bobbing_walking_speed * delta
	elif crouching:
		head_bobbing_current_intensity = data.head_bobbing_crouching_intensity
		head_bobbing_index += data.head_bobbing_crouching_speed * delta
	if is_on_floor() && !sliding && input_dir != Vector2.ZERO:
		head_bobbing_dir.y = sin(head_bobbing_index)
		head_bobbing_dir.x = sin(head_bobbing_index / 2.0) + 0.5
		eyes.position.y = lerp(
			eyes.position.y, 
			head_bobbing_dir.y * (head_bobbing_current_intensity / data.head_bobbing_horizontal_sway),
			delta * data.head_bobbing_lerp_speed)
		eyes.position.x = lerp(
			eyes.position.x, 
			head_bobbing_dir.x * head_bobbing_current_intensity,
			delta * data.head_bobbing_lerp_speed)
	else:
		eyes.position = lerp(eyes.position, Vector3.ZERO, delta * data.head_bobbing_lerp_speed)

func handle_input() -> void:
	var previous_input := input_dir
	var horizontal_input := InputActionMapManager.get_axis("left", "right")
	var vertical_input := InputActionMapManager.get_axis("forward", "backward")
	input_dir = Vector2(horizontal_input, vertical_input)
	if previous_input == Vector2.ZERO and input_dir != Vector2.ZERO:
		start_moving.emit()
	elif previous_input != Vector2.ZERO and input_dir == Vector2.ZERO:
		stop_moving.emit()

# TODO: Move all input reloated code to its own script