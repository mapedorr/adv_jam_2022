tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _input_event(_viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		match shape_find_owner(shape_idx):
			0:
				description = 'Memory viewer'
			1:
				description = 'Holomap'
			2:
				description = 'Gallic acid'
		_toggle_description(true)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: Nope...',
		"Player: I don't want to break anything"
	]), 'completed')
	
#	match description:
#		'Memory viewer':
#			E.run([])
#		'Holomap':
#			E.run([])
#		'Gallic acid':
#			E.run([])


# When the node is right clicked
func on_look() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	match description:
		'Memory viewer':
			E.run([
				G.display('This looks like the Memory Viewer from Little Big Adventure 2'),
				'Player: I wonder what this is for...',
				G.display('You could use it to watch all the cutscenes in the game'),
			])
		'Holomap':
			E.run([
				G.display('This looks like the Holomap from Little Big Adventure 2'),
				'Player: I like this model of a planet with two suns.',
				'Player: It has a lot of little details.'
			])
		'Gallic acid':
			E.run([
				G.display('A bottle of Gallic acid from Little Big Adventure 2'),
				'Player: I like the design of this bottle.',
			])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	E.run(["Player: Don't want to break anything..."])
