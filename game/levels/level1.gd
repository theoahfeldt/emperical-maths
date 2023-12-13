extends LevelCreator


static func create() -> Level:
	var left := AlgebraicSum.create(
			AlgebraicVariable.create("a"), AlgebraicInteger.zero())
	var right := AlgebraicVariable.create("a")
	var equality := AlgebraicEquality.create(left, right)
	var algebraic_rules: Array[AlgebraicRule] = [
		Identity.new(),
		SumIdentityRightForward.new(),
		SumIdentityRightBackward.new(),
	]
	return Level.create(equality, algebraic_rules, [])
