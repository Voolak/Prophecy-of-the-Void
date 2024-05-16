extends Camera2D

var _intensity = 1
var _duration = 1
var _start_time = 0
var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var decreaser = (_duration - (Time.get_ticks_msec() - _start_time)) / _duration
	
	var rand_x = _rng.randf_range(-1, 1) * _intensity * decreaser
	var rand_y = _rng.randf_range(-1, 1) * _intensity * decreaser
	
	offset = Vector2(rand_x,rand_y)
	
	if decreaser < 0:
		offset = Vector2.ZERO
		set_process(false)

func shake_camera(intensity = 3.0, duration = 1.0):
	_intensity = float(intensity)
	_duration = float(duration * 1000)
	_start_time = Time.get_ticks_msec()
	
	set_process(true)
