extends CharacterBody2D


####MAQUINAS DE ESTADOS#####
const NO_CHAO = 1
const NO_AR = 2
const CAINDO = 3
var estado_pulo = NO_CHAO

const PARADO = 4
const CORRENDO = 6
var estado_movimento = PARADO

const EM_PE = 8
const AGACHADO = 9
var estado_personagem = EM_PE
#####

var dont_move = false

@export var gravidade = 10
var gravidade_multiplicador : float = 2.0
@export var velocidade_maxima : int = 150
@export var velocidade_padrao : int = 20
var velocidade = velocidade_padrao

@export var pulo = -350



####MECANICAS DE PULO####
var buffer_jump = false
@onready var buffer_jump_timer = $buffer_jump
var coyote_jump = false
@onready var coyote_jump_timer = $coyote_jump
#####

@onready var animation = $AnimatedSprite


func _ready():
	pass

func _physics_process(delta):
	move(delta)
	flipar(delta)
	####BUFFER_JUMP####
	if Input.is_action_just_pressed("pulo") and dont_move == false:
		buffer_jump = true
		buffer_jump_timer.start()
	#########

#######MAQUINA DE ESTADO DO PULO#######
	if estado_pulo == NO_CHAO:
		no_chao()
	elif estado_pulo == NO_AR:
		pulando()
	elif estado_pulo == CAINDO:
		caindo()


#######MAQUINA DE ESTADO DE MOVIMENTO#######
	if estado_movimento == PARADO:
		funcao_parado()
	elif estado_movimento == CORRENDO:
		funcao_correndo()


######GRAVIDADE#######
	move_and_slide()
	velocity.y += gravidade * gravidade_multiplicador
########

func flipar(delta):
	if velocity.x > 0:
		animation.flip_h = false
	if velocity.x < 0:
		animation.flip_h = true



func move(delta : float):

	
	var Input_vector = Vector2(Input.get_axis("esquerda","direita"),0)
	
	
	
	velocity += Input_vector * velocidade
	if velocity.x > velocidade_maxima:
		velocity.x = velocidade_maxima
	if velocity.x < -velocidade_maxima:
		velocity.x = -velocidade_maxima
	
	
	if Input_vector.x == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 7.5)
	
	
func no_chao():
	#####COYOTE_JUMP$####
	if not is_on_floor() and coyote_jump == false:
		coyote_jump = true
		coyote_jump_timer.start()
		
######
	
####PULAR######
	if Input.is_action_just_pressed("pulo") and dont_move == false or buffer_jump and Input.is_action_pressed("pulo"):
		velocity.y = pulo
		animation.play("pulando")
		estado_personagem = EM_PE
		estado_pulo = NO_AR
		
		
	if velocity.y > 100:
		animation.play("pulando")
		estado_pulo = CAINDO
	
######


func pulando(): 
	
	if Input.is_action_just_released("pulo"):
		velocity.y *= 0.5
#####INDENTIFICAR SE ESTA NO CHAO OU CAINDO######
	if is_on_floor():
		animation.play("parado")
		estado_pulo = NO_CHAO
		
	elif velocity.y > 0:
		animation.play("pulando")
		estado_pulo = CAINDO
#######

func caindo():

#####INDENTIFICAR SE O PLAYER ESTA ANDANDO PARADO OU CORRENDO QUANDO CAIR ##########
	
	if is_on_floor() && estado_movimento == PARADO:
		animation.play("parado")
		estado_pulo = NO_CHAO
	
	if is_on_floor() && estado_movimento == CORRENDO:
		animation.play("andando")
		estado_pulo = NO_CHAO
		
########

func funcao_parado():
	
######ANIMACAO PARADO DEPOIS DE PULAR#####
	if estado_pulo == NO_CHAO and estado_personagem == EM_PE and is_on_floor():
		animation.play("parado")
#########


##### CORRER ANIMATION######
	
	if velocity.x != 0 && estado_pulo == NO_CHAO:
		estado_movimento = CORRENDO
		animation.play("andando")
	
######

func funcao_correndo():

####FICAR PARADO####
	if velocity.x == 0:
		animation.play("parado")
		estado_movimento = PARADO

####

#####TIMER JUMPER BUFFER E COYOTE JUMP#####
func _on_buffer_jump_timeout():
	buffer_jump = false

func _on_coyote_jump_timeout():
	coyote_jump = false
	estado_pulo = NO_AR
####

func _on_area_body_entered(body):
	if body.is_in_group("morte"): 
		get_tree().change_scene_to_file("res://cenes/explicacao.tscn")



func _on_area_area_entered(area):
	if area.is_in_group("morte"): 
		get_tree().change_scene_to_file("res://cenes/explicacao.tscn")
	
	if area.is_in_group("NICOLAS CAGE"): 
		get_tree().change_scene_to_file("res://cenes/NICOLAS.tscn") 
