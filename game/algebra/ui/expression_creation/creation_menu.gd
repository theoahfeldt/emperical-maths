class_name CreationMenu


enum Option {VARIABLE, INTEGER, NEGATION, SUM}


static func create(original: AlgebraicExpression) -> SelectionMenu:
	var options: Array = [
		original.copy(),
		Option.VARIABLE,
		Option.INTEGER,
		Option.NEGATION,
		Option.SUM,
	]
	var graphical := original.to_graphical()
	graphical.set_color_from_expression(original)
	var graphical_options: Array[GraphicalExpression] = [
		graphical,
		GraphicalVariable.create("a"),
		GraphicalInteger.create(0),
		GraphicalNegation.create(GraphicalVariable.create("_")),
		GraphicalSum.create(
				GraphicalVariable.create("_"), GraphicalVariable.create("_")),
	]
	return SelectionMenu.create(options, graphical_options)
