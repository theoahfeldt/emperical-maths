class_name GraphicalBase
extends GraphicalComponent


var expression: GraphicalExpressionOrMenu
var center_position: Vector2


func _process(delta: float) -> void:
	update_position(delta)


func get_size() -> Vector2i:
	return expression.get_size()


static func create(
		p_expression: GraphicalExpressionOrMenu,
		p_center_position := Vector2.ZERO,
		) -> GraphicalBase:
	var new := GraphicalBase.new()
	new.initialize(p_expression, p_center_position)
	return new


func initialize(
		p_expression: GraphicalExpressionOrMenu,
		p_center_position := Vector2.ZERO,
		) -> void:
	add_child(p_expression)
	expression = p_expression
	center_position = p_center_position


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	new.position = Vector2.ZERO
	add_child(new)
	expression = new
	center()


func center() -> void:
	center_at(center_position)


func center_smooth() -> void:
	center_at_smooth(center_position)


func clear_color() -> void:
	expression.clear_color()
