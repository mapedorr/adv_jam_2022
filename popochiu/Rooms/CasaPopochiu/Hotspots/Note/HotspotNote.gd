tool
extends PopochiuHotspot
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	E.run([G.display("Take the book if you don't have control!!!")])


# When the node is right clicked
func on_look() -> void:
	if C.player.can_move:
		E.run(['Player: It is a note'])
	else:
		E.run([G.display("Take the book if you don't have control!!!")])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	E.run(['Player: Nope.'])
