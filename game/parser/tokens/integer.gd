class_name IntegerToken
extends Token


var value: int


static func create(p_value: int) -> IntegerToken:
	var new := IntegerToken.new()
	new.value = p_value
	return new


func _to_string() -> String:
	return "IntegerToken(%d)" % [value]
