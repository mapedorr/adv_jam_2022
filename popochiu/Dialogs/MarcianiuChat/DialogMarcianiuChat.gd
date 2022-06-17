tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func start() -> void:
	# One can put here something to excecute before showing the dialog options.
	# E.g. Make the PC to look at the character which it will talk to, walk to
	# it, and say something (or make the character say something)
	
	# This makes the options to appear
	.start()


func option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(E.run([
				'Marcianiu: Fine. Thanks for asking.',
				'Marcianiu: I really like being along from time to time.',
			]), 'completed')
			
			opt.turn_off()
		'Opt2':
			yield(E.run([
				'Marcianiu: Not hiding. I was just recovering energy.',
				'Marcianiu: And thinking.',
				'Marcianiu: This place serves as a portal to our world..',
				'Marcianiu: I was cleaning the dishes before Trapusinsiu called me.',
			]), 'completed')
			
			opt.turn_off()
		'Opt3':
			yield(E.run([
				"Marcianiu: No clue. Haven't seen him in months.",
				'Marcianiu: Neither have any of you.',
				'Player: He is lost and we suspect a Roberto kidnapped him.',
				'Marcianiu: Oh! Those annoying creatures.',
				'...',
				'Marcianiu: I can help you if you give me something in exchange.',
				'Player: What?',
				'Marcianiu: I really want an ice cream.',
				'Player: Any ice cream?',
				'Marcianiu: Of course not. I want a special one.',
				'Marcianiu: One with Corozo, Passion fruit and Lemon pie.',
				'Player: Ok... we will give you one.',
				'Marcianiu: Excellent!',
				'Marcianiu: Bring me the ice cream and I will give you guys a weapon and a tool.',
			]), 'completed')
			
			opt.turn_off()
			turn_on_options(['Opt4', 'Opt5'])
		'Opt4':
			yield(E.run([
				"Marcianiu: Corozo, Passion fruit and Lemon pie.",
				'Marcianiu: Want it so much!'
			]), 'completed')
		'Opt5':
			yield(E.run([
				"Marcianiu: Ok. I won't move.",
				'..',
				'Marcianiu: Literally.'
			]), 'completed')
			
			D.finish_dialog()
			return
	
	_show_options()
