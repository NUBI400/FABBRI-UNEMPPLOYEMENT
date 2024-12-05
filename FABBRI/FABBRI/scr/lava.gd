extends TileMap
@onready var timer = $Timer

@onready var fabbri = $"../Fabbri"
var vel = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	transform.origin.y -= vel
	


func _on_timer_timeout():
	vel += 0
