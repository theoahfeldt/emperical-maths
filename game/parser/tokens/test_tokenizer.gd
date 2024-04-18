extends Node


func _ready() -> void:
	print(Tokenizer.tokenize("-(a+-0)=0"))
	print(Tokenizer.tokenize("(a=b)=>+123-c"))
