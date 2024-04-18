class_name Implication
extends ParsableExpression


var antecedent: ManipulableExpression
var consequent: ManipulableExpression


func _to_string() -> String:
	return "%s=>%s" % [antecedent.to_string(), consequent.to_string()]


static func create(
		p_antecedent: ManipulableExpression,
		p_consequent: ManipulableExpression,
		) -> Implication:
	var new := Implication.new()
	new.antecedent = p_antecedent
	new.consequent = p_consequent
	return new
