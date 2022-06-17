tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	disable(false)
	
	if Globals.state.PUSHED_SAFEBOX:
		enable(false)
	
	if Globals.state.CHIQUINININ_FREED:
		$Sprite.frame = 1


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	if Globals.state.CHIQUINININ_FREED:
		E.run([
			'Player: Still smells like poop.'
		])
	else:
		E.run([
			'Player: We need a key to open this.',
			'Player: Chiquininín must be inside.',
		])


# When the node is right clicked
func on_look() -> void:
	if Globals.state.CHIQUINININ_FREED:
		E.run([
			C.face_clicked(),
			'Player: What an awkward place to hide a Popochiu.'
		])
	else:
		E.run([
			C.face_clicked(),
			'Player: Chiquininin must be inside that... thing.'
		])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	if item.script_name == 'Key':
		$Sprite.frame = 1
		Globals.state.CHIQUINININ_FREED = true
		
		I.remove_item('Key', false)
		C.get_character('Chiquininin').play_asleep()
		C.get_character('Chiquininin').enable(false)
		
		yield(E.run([
			'Player: Yeeeeeeey!!!!',
			'Player: Oh my! That smell... may be he is...',
			'...',
			'Player: DEAD!?',
			'...',
			C.get_character('Chiquininin').play_wakeup(),
			'Chiquininin(happy): ' + Utils.say_in_popochiu('iiiiiiiiiiiiiiiiiiiiiiiiiiii!!!!', 'laughs super happy'),
			'Chiquininin(happy): I pooped...!',
			'Chiquininin(happy): Several times.',
		]), 'completed')
		
		Globals.playable_popochius.append('Chiquininin')
		
		E.goto_room('CasaPopochiu')
	else:
		E.run(['Player: No.'])
