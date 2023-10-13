extends KinematicBody2D

class_name Character

const FRICTION: float = 0.15

export(int) var hp: int = 2 
export(int) var acceleration: int = 40
export(int) var max_speed: int = 100

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

		
func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration

func take_damage(dam: int, dir: Vector2, force: int) -> void:
	hp -= dam
	if hp>0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2
