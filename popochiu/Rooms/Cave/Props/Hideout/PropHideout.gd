tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	if Globals.state.SYMBOL_ACTIVATED:
		$CollisionPolygon2D.disabled = true
		$Door.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	E.run([
		"Player: It doesn't move."
	])


# When the node is right clicked
func on_look() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	E.run([
		'Player: A rock that looks like a door with an engraved symbol.'
	])


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	E.run(['Player: How?'])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func open() -> void:
	yield(get_tree().create_timer(0.5), 'timeout')
	
	$Door.frame = 1
	
	yield(get_tree().create_timer(2.0), 'timeout')
	
	room.put_marcianiu_on_top()
	C.get_character('Marcianiu').enable(false)
	$CollisionPolygon2D.disabled = true
	$Door.hide()
	C.character_walk_to('Marcianiu', room.get_point('HideoutEntrance'), false)
