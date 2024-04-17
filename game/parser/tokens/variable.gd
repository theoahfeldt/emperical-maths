class_name VariableToken
extends Token


var name: String


static func create(p_name: String) -> VariableToken:
	var new := VariableToken.new()
	new.name = p_name
	return new


func _to_string() -> String:
	return "VariableToken(%s)" % [name]
