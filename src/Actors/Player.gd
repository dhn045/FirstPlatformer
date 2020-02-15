extends Actor


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body):
	queue_free()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction()
	_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculate_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var res = linear_velocity
	res.x = speed.x * direction.x
	res.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		res.y = speed.y * direction.y
	if is_jump_interrupted:
		res.y = 0.0
	return res

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var res: = linear_velocity
	res.y = -impulse
	return res
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
