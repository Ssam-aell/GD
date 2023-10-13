extends Character

onready var melee: Node2D = get_node("Melee")
onready var melee_hitbox: Area2D = get_node("Melee/Node2D/Sprite/Hitbox")
onready var melee_animation_player: AnimationPlayer = melee.get_node("MeleeAnimationPlayer")

func _physics_process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	
	melee.rotation = mouse_direction.angle()
	melee_hitbox.knockback_direction = mouse_direction
	if melee.scale.y == 1 and mouse_direction.x < 0:
		melee.scale.y = -1
	elif melee.scale.y == -1 and mouse_direction.x > 0:
		melee.scale.y = 1

	
func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
		
	if Input.is_action_just_pressed("ui_attack") and not melee_animation_player.is_playing():
		melee_animation_player.play("attack")
