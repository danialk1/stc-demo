extends Area2D

signal hit

export var speed = 400
var screen_size
var health = 30

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var degree = rad2deg(atan2((event.position.x-get_viewport_rect().size.x/2),(get_viewport_rect().size.y/2-event.position.y)))
				get_node("Fist").punch(degree)

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_key_pressed(KEY_D):
		velocity.x += 1
	if Input.is_key_pressed(KEY_A):
		velocity.x -= 1
	if Input.is_key_pressed(KEY_S):
		velocity.y += 1
	if Input.is_key_pressed(KEY_W):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#if velocity.x != 0:
	#	$AnimatedSprite.animation = "walk"
	#	$AnimatedSprite.flip_v = false
	#	# See the note below about boolean assignment
	#	$AnimatedSprite.flip_h = velocity.x < 0
	var mousex = get_viewport().get_mouse_position().x
	var mousey = get_viewport().get_mouse_position().y
	var midx = get_viewport_rect().size.x/2
	var midy = get_viewport_rect().size.y/2
	
	if mousey - midy > mousex - midx:
		if mousey - midy > midx - mousex:
			$AnimatedSprite.animation = "down"
		else:
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.flip_h = true
	else:
		if mousey - midy > midx - mousex:
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.animation = "up"


func _on_Player_body_entered(body):
	health-=10
	if(health<0):
		hide()  # Player disappears after being hit.
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
