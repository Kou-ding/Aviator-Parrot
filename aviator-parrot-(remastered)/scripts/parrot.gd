extends CharacterBody2D

const JUMP_VELOCITY = -500.0
var jump_button = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.5
		if velocity.y>0:
			#rotation = 0.5
			$AnimatedSprite2D.frame=0
			$CollisionPolygon2DF0.disabled = false
			$CollisionPolygon2DF1.disabled = true
		if velocity.y<0:
			#rotation = -0.5
			$AnimatedSprite2D.frame=1
			$CollisionPolygon2DF0.disabled = true
			$CollisionPolygon2DF1.disabled = false
	
	# Handle jump
	if Input.is_action_just_pressed("jump"):	
		velocity.y = JUMP_VELOCITY
	move_and_slide()

func start(pos):
	position = pos
	show()
	$CollisionPolygon2DF0.disabled = false
	$CollisionPolygon2DF1.disabled = false

func game_jump_button_pressed() -> void:
	velocity.y = JUMP_VELOCITY
	move_and_slide()
	
