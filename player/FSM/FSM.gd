#главный контроллен
class_name StateMachine
extends Node
#в этой переменной будет содержаться ссылка на какую-нибуь ноду(*путь)и т.к мы использовали export 
#она будет видна в инспекторе
@export var start_state: NodePath

@onready var state: State = get_node(start_state)
# Called when the node enters the scene tree for the first time.
func _ready():
	#функция get возвращает массив всех дочерних нод и с циклом фор мы по ним пробегаем
	for child in get_children():
		#print(child)
		#Этот код пройдет через все дочерние узлы текущего узла и установит переменную state_machine каждого дочернего узла
		# в текущий узел (то есть self). По сути, это связывает каждый
		# дочерний узел с родительским узлом, предоставляя им доступ к свойствам и методам родителя через state_machine.
		child.state_machine = self
	state.enter()
	
func _unhandled_input(event):
	state.inner_unhandled_input(event)
func _process(delta):
	state.inner_process(delta)
func _physics_process(delta):
	state.inner_physics_process(delta)
#изменеие состояния
func change_to(target_state: String, mess:Dictionary={}):
	#проверка есть ли состояние которое запрашивается 
	if not has_node(target_state):
		print("Запрошенo неверное состояние " + target_state)
		return
	if "state" not in mess:
		mess["state"] = state.get_name()
	state.exit()
	state = get_node(target_state)
	state.enter(mess)
	print("переход в состояние " + state.name)	






