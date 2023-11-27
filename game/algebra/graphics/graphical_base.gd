class_name GraphicalBase
extends GraphicalComponent


var expression: GraphicalExpressionOrMenu


func _process(delta: float) -> void:
	update_position(delta)


func get_size() -> Vector2i:
	return expression.get_size()


static func create(p_expression: GraphicalExpressionOrMenu) -> GraphicalBase:
	var new := GraphicalBase.new()
	new.initialize(p_expression)
	return new


func initialize(p_expression: GraphicalExpressionOrMenu) -> void:
	add_child(p_expression)
	expression = p_expression


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	new.position = Vector2.ZERO
	add_child(new)
	expression = new
	center_in_viewport()


func clear_color() -> void:
	expression.clear_color()
