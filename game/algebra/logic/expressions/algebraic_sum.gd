class_name AlgebraicSum
extends AlgebraicExpression


@export var left_term: AlgebraicExpression
@export var right_term: AlgebraicExpression


static func create(a: AlgebraicExpression, b: AlgebraicExpression) -> AlgebraicSum:
	var sum = AlgebraicSum.new()
	sum.initialize(a, b)
	return sum


func initialize(a: AlgebraicExpression, b: AlgebraicExpression) -> void:
	add_child(a)
	add_child(b)
	left_term = a
	right_term = b


func copy() -> AlgebraicExpression:
	var new = AlgebraicSum.new()
	var a = left_term.copy()
	var b = right_term.copy()
	new.initialize(a, b)
	return new


func replace_left_term(new: AlgebraicExpression) -> void:
	remove_child(left_term)
	left_term.queue_free()
	add_child(new)
	left_term = new


func replace_right_term(new: AlgebraicExpression) -> void:
	remove_child(right_term)
	right_term.queue_free()
	add_child(new)
	right_term = new


func pretty_string() -> String:
	return "(%s + %s)" % [left_term.pretty_string(), right_term.pretty_string()]
