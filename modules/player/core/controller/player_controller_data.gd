class_name PlayerControllerData
extends Resource

@export var walking_speed: float = 3.0
@export var sprinting_speed: float = 5.0
@export var crouching_speed: float = 1.5
@export var sliding_speed: float = 8.0
@export var decceleration: float = 13.0

@export var jump_velocity: float = 4.5
@export var weight_scale: float = 1

@export var mouse_sensitivity: float = 0.5
@export var vertical_look_min_angle: float = -80.0
@export var vertical_look_max_angle: float = 90.0
@export var free_look_angle: float = 90.0
@export var free_look_snap_lerp_speed: float = 20.0
@export var free_look_tilt_amount: float = 5.0

@export var crouching_height: float = -0.9
@export var height_lerp_speed: float = 10.0

@export var head_bobbing_sprinting_speed: float = 22
@export var head_bobbing_walking_speed: float = 14
@export var head_bobbing_crouching_speed: float = 10
@export var head_bobbing_sprinting_intensity: float = 0.2
@export var head_bobbing_walking_intensity: float = 0.1
@export var head_bobbing_crouching_intensity: float = 0.05
@export var head_bobbing_lerp_speed: float = 5.0
@export var head_bobbing_horizontal_sway: float = 1.0
