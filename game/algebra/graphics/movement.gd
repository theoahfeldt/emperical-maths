class_name Movement


var _start_position: Vector2
var _end_position: Vector2
var _time_s: float = 0
var _duration_s: float
var _is_complete := false


static func create(
		start_position: Vector2, end_position: Vector2, duration_s: float
		) -> Movement:
	var movement := Movement.new()
	movement._start_position = start_position
	movement._end_position = end_position
	movement._duration_s = duration_s
	return movement


func current_position() -> Vector2:
	if _time_s >= _duration_s:
		_is_complete = true
		return _end_position
	var t := _time_s / _duration_s
	return _start_position.lerp(_end_position, t)


func has_update(delta: float) -> bool:
	_time_s += delta
	return not _is_complete
