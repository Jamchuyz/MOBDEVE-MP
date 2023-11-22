extends CharacterBody2D

@onready var player
@onready var animation = get_node("AnimatedSprite2D")
@onready var cooldown = $AttackTimer
@onready var detection = $PlayerDetection/CollisionShape2D
@onready var soundFire = $FireSound
@export var projectile: PackedScene = preload("res://traps/Projectiles/fire_projectile_2.tscn")
var attack = false
var delay = 1.0
var cool_time = 0.05 #Shoots a stream of fire
var speed = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("idle")
	cooldown.wait_time = cool_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# Can only attack if player is in its kill zone and the cooldown is reached
	if attack == true && !player.isDed:
		animation.play("attack")
		await get_tree().create_timer(delay).timeout #Firing delay
		if cooldown.is_stopped():
			fire()
	else:
		animation.play("idle")


func fire():
	if projectile:
		var p = projectile.instantiate()
		get_tree().current_scene.add_child(p)
		p.global_position = self.global_position
		p.parent_scale = self.scale
		p.apply_scale(self.scale)
		p.SPEED = speed
		p.damage_taken.connect(player.on_damage_taken)
		soundFire.play()
		cooldown.start()


# When Player enters detection zone
func _on_player_detection_entered(area):
	if area.name == "PlayerHurtbox":
		attack = true
		


func _on_player_detection_exited(area):
	if area.name == "PlayerHurtbox":
		attack = false
