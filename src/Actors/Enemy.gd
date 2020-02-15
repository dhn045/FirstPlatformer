extends "res://src/Actors/Actor.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_Stomp_Detector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("Stomp Detector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


