extends Spatial

export (PackedScene) var projectile

export var firing_rate = 1

var firing = false

onready var aim_location = $AimLocation
onready var firing_location = $FiringLocation

func _ready():
	aim_location.cast_to = Vector3(0, 0, -999999999)

func _process(_delta):
	aim_location.force_raycast_update()
	firing_location.look_at(aim_location.get_collision_point(), Vector3(0, 1, 0))

func primary_fire():
	if not firing:
		firing_location.add_child(projectile.instance())
		firing = true
		yield(get_tree().create_timer(firing_rate), "timeout")
		firing = false
