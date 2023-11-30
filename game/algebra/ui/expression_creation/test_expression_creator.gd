extends Node2D


func _ready() -> void:
	$ExpressionCreator.initialize(get_viewport_rect().size / 2.0)


func _process(_delta: float) -> void:
	$ExpressionCreator.process_input()
