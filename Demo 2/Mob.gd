extends RigidBody2D

export var min_speed = 150
export var max_speed = 250


func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Mob_body_entered(body):
	hide()  # Player disappears after being hit.
	print("pow!")
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
