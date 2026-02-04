extends Node2D

var crystals_speed = 450

signal passed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	position.x -= crystals_speed*delta

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	passed.emit()

func _on_selfdestruct_timeout() -> void:
	queue_free()
