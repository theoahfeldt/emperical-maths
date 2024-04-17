class_name SymbolToken
extends Token


enum {
	LEFT_PARENTHESIS,
	RIGHT_PARENTHESIS,
	PLUS,
	MINUS,
	EQUALS,
	IMPLIES,
}


const _strings := {
	LEFT_PARENTHESIS: "(",
	RIGHT_PARENTHESIS: ")",
	PLUS: "+",
	MINUS: "-",
	EQUALS: "=",
	IMPLIES: "=>",
}


var type: int


static func create(p_type: int) -> SymbolToken:
	var new := SymbolToken.new()
	new.type = p_type
	return new


func _to_string() -> String:
	return "SymbolToken(\"%s\")" % _strings[type]
