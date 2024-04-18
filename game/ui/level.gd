class_name Level


var equality: AlgebraicEquality
var rules: Array[ManipulationRule]


static func create(
		p_equality: AlgebraicEquality,
		p_rules: Array[ManipulationRule],
		) -> Level:
	var new := Level.new()
	new.equality = p_equality
	new.rules = p_rules
	return new
