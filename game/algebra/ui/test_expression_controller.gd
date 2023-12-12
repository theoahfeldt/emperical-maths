extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var left := AlgebraicSum.create(
			AlgebraicVariable.create("a"), AlgebraicInteger.zero())
	var right := AlgebraicVariable.create("a")
	var equality := AlgebraicEquality.create(left, right)
	var base := AlgebraicBase.create(equality)
	var expression_controller := ExpressionController.create(base, center)
	add_child(expression_controller)
