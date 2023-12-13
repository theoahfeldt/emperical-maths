extends LevelCreator


static func create() -> Level:
	var left := AlgebraicSum.create(
			AlgebraicInteger.zero(), AlgebraicVariable.create("a"))
	var right := AlgebraicVariable.create("a")
	var equality := AlgebraicEquality.create(left, right)
	var algebraic_rules: Array[AlgebraicRule] = [
		Identity.new(),
		SumIdentityLeftForward.new(),
		SumIdentityLeftBackward.new(),
	]
	return Level.create(equality, algebraic_rules)
