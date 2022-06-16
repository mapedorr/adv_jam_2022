tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	if I.is_item_in_inventory('Scepter')\
	or Globals.state.SCEPTER_IN_PLACE or Globals.state.SCEPTER_PUSHED:
		$Sprite.frame = 1


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	yield(E.run([
		'Player: All this free toys suck!',
	]), 'completed')
	
	if $Sprite.frame == 1:
		E.run(['Player: In comparison... the scepter was not so bad.'])
		return
	
	var choice: PopochiuDialogOption = yield(
		D.show_inline_dialog([
			'Take the scepter.',
			'Do not take any toys.'
		]), 'completed'
	)
	
	match choice.id:
		'Opt1':
			E.run([
				'Player: Ooook...',
				E.runnable($Sprite, 'set_frame', [1]),
				I.add_item('Scepter'),
				'Player: Why would anyone want such an ugly toy?'
			])
		_:
			E.run(['Player: I thought so.'])


# When the node is right clicked
func on_look() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	E.run([
		'Player: A box full of free and ugly toys no one wants to play with.',
		'...',
		'Player: Well... maybe Chiquininín.'
	])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	E.run(["Player: I don't want to put this into that box of ugly toys."])
