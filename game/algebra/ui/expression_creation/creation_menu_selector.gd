class_name CreationMenuSelector
extends MenuSelector


enum Option {VARIABLE, INTEGER, NEGATION, SUM}

signal selected_original(algebraic, graphical, mark)
signal selected_new(option, mark)

var _mark: Array[int]


func _select() -> void:
	var option = _menu.adopt_marked_option()
	if option is AlgebraicExpression:
		var graphical: GraphicalExpression = _menu.adopt_marked_graphical_option()
		selected_original.emit(option, graphical, _mark)
	elif option is Option:
		selected_new.emit(option, _mark)
	else:
		push_error("Unexpected type of menu option")


func initialize(original: AlgebraicExpression, mark: Array[int]) -> SelectionMenu:
	var options: Array = [
		original.copy(),
		Option.VARIABLE,
		Option.INTEGER,
		Option.NEGATION,
		Option.SUM,
	]
	var graphical := original.to_graphical()
	graphical.set_color_from_algebraic(original)
	_mark = mark
	var graphical_options: Array[GraphicalExpression] = [
		graphical,
		GraphicalVariable.create("a"),
		GraphicalInteger.create(0),
		GraphicalNegation.create(GraphicalVariable.create("_")),
		GraphicalSum.create(
				GraphicalVariable.create("_"), GraphicalVariable.create("_")),
	]
	_menu = SelectionMenu.create(options, graphical_options)
	return _menu
