extends Projectile
class_name ColliderProjectile

func _on_hitbox_body_entered(body: Node3D) -> void:
	print("body: %s" % body)
	queue_free()

func _on_hitbox_area_entered(_area:Area3D) -> void:
	pass

