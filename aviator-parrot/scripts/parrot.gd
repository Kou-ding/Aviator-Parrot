extends CharacterBody2D

const JUMP_VELOCITY = -400.0
@onready var jump_button = $"../TouchToJump"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y>0:
			rotation = 0.5
		if velocity.y<0:
			rotation = -0.5
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") or jump_button.is_pressed():	
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()
