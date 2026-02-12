extends CharacterBody2D

const JUMP_VELOCITY = -1300.0
var jump_button = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 3 * get_gravity() * delta
		if velocity.y<-300:
			$AnimatedSprite2D.frame=0
			$CollisionShape2DF2.disabled = true
			$CollisionPolygon2DF1.disabled = true
			$CollisionPolygon2DF0.disabled = false
		if velocity.y>300:
			$AnimatedSprite2D.frame=1
			$CollisionShape2DF2.disabled = true
			$CollisionPolygon2DF1.disabled = false
			$CollisionPolygon2DF0.disabled = true
		if velocity.y>-300 and velocity.y<300:
			$AnimatedSprite2D.frame=2
			$CollisionShape2DF2.disabled = false
			$CollisionPolygon2DF1.disabled = true
			$CollisionPolygon2DF0.disabled = true

	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if position.y>0:
			velocity.y = JUMP_VELOCITY
			$FlapWings.play()
			
	# A default collision/sliding response
	move_and_slide()

func start(pos):
	position = pos
	show()
	$CollisionShape2DF2.disabled = false
	$CollisionPolygon2DF1.disabled = false
	$CollisionPolygon2DF0.disabled = false

func game_jump_button_pressed() -> void:
	if position.y>0:
		velocity.y = JUMP_VELOCITY
		$FlapWings.play()
	
