class_name AlgebraicSum
extends AlgebraicExpression


@export var left_term: AlgebraicExpression
@export var right_term: AlgebraicExpression


static func create(a: AlgebraicExpression, b: AlgebraicExpression) -> AlgebraicSum:
	var sum = AlgebraicSum.new()
	sum.left_term = a
	sum.right_term = b
	return sum


func replace(other: AlgebraicSum) -> void:
	left_term = other.left_term
	right_term = other.right_term


func _to_string() -> String:
	return "(%s + %s)" % [str(left_term), str(right_term)]
