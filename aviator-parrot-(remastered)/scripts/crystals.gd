extends Node2D

var crystals_speed = 450

signal passed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	position.x -= crystals_speed*delta

func _on_selfdestruct_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	passed.emit()
	call_deferred("disable_collision")

func disable_collision():
	$Area2D/CollisionShape2D.disabled = true
