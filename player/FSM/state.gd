#state_gd(базовый класс состояний состояния)
extends Node
class_name State
#переменная в которой находится указания на действующий контроллер(если нужно сменить состояние от run к idle итд)
var state_machine=null
#функции будут внутренними в них будем передовать значение из реальных функций(проводники)
func inner_unhandled_input(_event: InputEvent):
	pass

func inner_process(_delte: float):
	pass
	
func inner_physics_process(_delta: float):
	pass
# то что будет сделано при входе в конкретное состояние передовать в функцию будем словарь(например когда мы переходим из
#состояния бег в покой нам нужно будет передать какие-то данные состояния их передаем через словарь)
func enter(_mess: Dictionary={}):
	pass
func exit():
	pass
