tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	if Globals.state.SCEPTER_IN_PLACE:
		$Sprite.frame = 1
	elif Globals.state.SCEPTER_PUSHED:
		$Sprite.frame = 2
	else:
		$Sprite.frame = 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	match $Sprite.frame:
		0:
			E.run([
				'Player: We have nothing to do in here.'
			])
		1:
			if C.player.script_name != 'Gonorrein':
				E.run([
					"Player: Can't push it!"
				])
			else:
				Globals.state.SCEPTER_PUSHED = true
				
				yield(E.run([
					'Player: GrrrrrRRRRRRRAAAAAAAHHHHHHHHH!.'
				]), 'completed')
				
				$Sprite.frame = 2
				
				E.run([
					'Player: ' + Utils.say_in_popochiu('iiiiiiii!!!!!', 'Yey!')
				])
		2:
			E.run([
				'Player: Yeeeyyy!',
				'Player: Is glowing.'
			])


# When the node is right clicked
func on_look() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	match $Sprite.frame:
		0:
			E.run([
				'Player: Looks like one can put something in there.'
			])
		1:
			E.run([
				'Player: The scepter is in... now what?'
			])
		2:
			E.run([
				'Player: Looks like it activated some sort of energy...'
			])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	if item.script_name == 'Scepter':
		Globals.state.SCEPTER_IN_PLACE = true
		
		yield(E.run([
			I.remove_item('Scepter'),
			'Player: Fits perfectly!'
		]), 'completed')
		
		$Sprite.frame = 1
	else:
		E.run([
			'Player: It does not fit.'
		])
