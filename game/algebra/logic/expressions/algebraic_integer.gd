class_name AlgebraicInteger
extends AlgebraicExpression


@export var value: int


static func create(value: int) -> AlgebraicInteger:
	var integer = AlgebraicInteger.new()
	integer.value = value
	return integer


static func zero() -> AlgebraicInteger:
	return create(0)


func copy() -> AlgebraicExpression:
	var new = AlgebraicInteger.new()
	new.value = value
	return new


func pretty_string() -> String:
	return str(value)


func is_zero() -> bool:
	return value == 0
