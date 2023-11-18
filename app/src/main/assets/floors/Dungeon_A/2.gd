extends Node2D

@onready var player = get_node("Player")
@onready var endpoint = get_node("EndPoint")
@onready var dragons1 = [get_node("DragonGargoyle"), get_node("DragonGargoyle2")]
@onready var dragons2 = [get_node("DragonGargoyle3"), get_node("DragonGargoyle4")]
@onready var pitfalls = [get_node("Pitfall"), get_node("Pitfall2")]

# Called when the node enters the scene tree for the first time.
func _ready():
	#Connect endpoint to change floor
	endpoint.changeFloor.connect(PlayerData.dungeonAFloorMovement)
	
	#Init traps
	for d in dragons1: #Dragons on Bottom
		d.player = player
		d.speed = 350
		d.detection.apply_scale(Vector2(1, 4))
	for d in dragons2: #Dragons on top route
		d.player = player
		d.detection.apply_scale(Vector2(2, 2))
		d.cooldown.wait_time = 2.5
	for p in pitfalls:
		p.fallen_down.connect(player.ive_fallen)