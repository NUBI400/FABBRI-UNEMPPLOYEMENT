extends Node2D

@export var padrao1 : TileMap
@export var padrao2 : TileMap


var p1 = preload("res://cenes/Padroes/Padrao1.tscn")
var p2 = preload("res://cenes/Padroes/Padrao2.tscn")
var p3 = preload("res://cenes/Padroes/Padrado3.tscn")

#var travanabase = preload("res://cenas/travanabase.tscn")

var rng = RandomNumberGenerator.new()

var count = 0


func _physics_process(delta):
	
	
	
	padrao1.transform.origin.y += 0.2
	padrao2.transform.origin.y += 0.2
	
	print(padrao1.transform.origin.y)
	if (padrao1.transform.origin.y>=-200):
		var numero = rng.randi_range(1,3)
		var novopadrao
		if numero==1:
			novopadrao = p1.instantiate()
		elif numero==2:
			novopadrao = p2.instantiate()
		elif numero==3:
			print(3333333333)
			novopadrao = p3.instantiate()
		novopadrao.transform.origin.y = -720
		add_child(novopadrao)
		padrao1.queue_free() 
		padrao1 = novopadrao

	if (padrao2.transform.origin.y>=720):
		
		var numero = rng.randi_range(1,3)
		var novopadrao
		if numero==1:
			novopadrao = p1.instantiate()
		elif numero==2:
			novopadrao = p2.instantiate()
		elif numero==3:
			print(333333333333)
			novopadrao = p3.instantiate()
			
		novopadrao.transform.origin.y = -720
		add_child(novopadrao)
		padrao2.queue_free()
		padrao2 = novopadrao
