tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func start() -> void:
	yield(E.run([
		'Roberto: Yikes!!!',
		'Roberto: How did you get here!?',
		'Roberto: To my...',
		'...',
		'Roberto: Secret place.'
	]), 'completed')
	
	# This makes the options to appear
	.start()


func option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(E.run([
				"Roberto: I don't know what ya takin about.",
				'Gonorrein: Bullshit!',
				
				# TODO: Que se muestren opciones de acusación chistosas
				
				'Popsy: I felt your smell last night.',
				'Popsy: And I smell a faint whiff of Chiquinin in this place.',
				'...',
				'Roberto: Well... maybe I have Chiquininín.',
				'Roberto: And what you gonna do!?',
				'Roberto: You fear me so much that you will not be able to get close.'
			]), 'completed')
		'Opt2':
			yield(E.run([]), 'completed')
