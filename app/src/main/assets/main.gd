extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#Use this scene to load data from database and perform logic of
	#selecting the random floor levels. Maybe use a naming convention
	#for floors like "floor_b(floor_number)_(variation)(a,b,c... for difficulty levels)"
	
	PlayerData.initData()
	get_node("TestOutputLabel").text = "Health: " + str(PlayerData.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
