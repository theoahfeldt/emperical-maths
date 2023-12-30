extends LevelCreator


static func create() -> Level:
	var left := AlgebraicSum.create(
			AlgebraicVariable.create("a"), AlgebraicInteger.zero())
	var right := AlgebraicSum.create(
			AlgebraicInteger.zero(), AlgebraicVariable.create("a"))
	var equality := AlgebraicEquality.create(left, right)
	var algebraic_rules: Array[AlgebraicRule] = [
		Identity.new(),
		SumIdentityRightForward.new(),
		SumIdentityLeftForward.new(),
		SumIdentityRightBackward.new(),
		SumIdentityLeftBackward.new(),
	]
	return Level.create(equality, algebraic_rules)
