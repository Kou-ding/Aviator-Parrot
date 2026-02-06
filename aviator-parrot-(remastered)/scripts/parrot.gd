extends CharacterBody2D

const JUMP_VELOCITY = -1300.0
var jump_button = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 3 * get_gravity() * delta
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
		$FlapWings.play()
	move_and_slide()

func start(pos):
	position = pos
	show()
	$CollisionPolygon2DF0.disabled = false
	$CollisionPolygon2DF1.disabled = false

func game_jump_button_pressed() -> void:
	velocity.y = JUMP_VELOCITY
	$FlapWings.play()
	move_and_slide()
	
