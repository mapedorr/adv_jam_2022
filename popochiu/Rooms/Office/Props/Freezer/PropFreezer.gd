tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	enable(false)
	
	if Globals.office != Globals.MAIN_OFFICE:
		disable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	if C.player.script_name == 'Popsy':
		yield(E.run([
			'Player: Which ice cream flavor should I make.',
		]), 'completed')
		
		var choice: PopochiuDialogOption = yield(
			D.show_inline_dialog([
				'Brownie + Camu camu + Asaí',
				'Corozo + Passion fruit + Lemon pie',
				'Lemon grass + Vanilla + Grapes',
			]), 'completed'
		)
		
		var target_item := 'IceCream'
		match choice.id:
			'Opt1':
				target_item = 'IceCream2'
			'Opt3':
				target_item = 'IceCream3'
		
		if I.is_item_in_inventory(target_item):
			E.run([
				'Player: We already have one of those.',
				"Player: I'll make another one once we finish that one.",
			])
		else:
			E.run([
				I.add_item(target_item),
				'Player: %s ice cream done.' % choice.text,
				"Player: You're welcome."
			])
	else:
		yield(E.run([
			'Player: I like how it looks.',
			'Player: Sadly... it is empty.'
		]), 'completed')


# When the node is right clicked
func on_look() -> void:
	if C.player.script_name == 'Popsy':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Player: mmmmm.....',
			'...',
			'Player: Like it.',
			'Player: Now will be able to compete with La Conchita.'
		]), 'completed')
	else:
		yield(E.run([
			C.face_clicked(),
			'Player: That freezer rocks!'
		]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: Emmm....... No.',
	]), 'completed')
