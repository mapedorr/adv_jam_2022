tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func start() -> void:
	yield(E.run_cutscene([
		'Roberto: Yikes!!!',
		'Roberto: How did you get here!?',
		'Roberto: To my...',
		'...',
		'Roberto: Secret place.',
		'Player: We came to rescue someone.',
		E.current_room.place_popochius(),
		'Roberto: Oh!...'
	]), 'completed')
	
	# This makes the options to appear
	.start()


func option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(E.run_cutscene([
				'Goddiu: Tell us where you hid Chiquininín.',
				"Roberto: I don't know what ya takin about.",
				'Gonorrein: Bullshit piece of...!!!',
				'Trapusinsiu: BAD GUY!',
			]), 'completed')
			
			opt.turn_off()
			turn_on_options(['Opt2', 'Opt3', 'Opt4'])
		'Opt2':
			yield(E.run_cutscene([
				'Goddiu: You Robertos are mean!',
				'Popsy: Yeah! The other day an employee in La Conchita complained that one of you left the toilet dirty.',
				'Trapusinsiu: And a couple of months ago a group of Robertos went to the park to scare dogs!',
				'Gonorrein: And the list can go on.',
				'Roberto: Well... all that sounds funny... but that does not prove that I have Chiquininín.'
			]), 'completed')
			
			opt.turn_off()
		'Opt3':
			yield(E.run_cutscene([
				'Popsy: I felt your smell last night.',
				'Popsy: And I smell a faint whiff of Chiquinin in this place.',
				'...',
				'Roberto: Well... maybe I have Chiquininín.',
				'Roberto: And what you gonna do!?',
				'Roberto: You fear me so much that you will not be able to get close.'
			]), 'completed')
			
			turn_off_options(['Opt2', 'Opt3', 'Opt4'])
			turn_on_options(['Opt5', 'Opt6', 'Opt7'])
		'Opt4':
			yield(E.run_cutscene([
				'Trapusinsiu: This would not be the first time this has happened.',
				'Goddiu: The other day one of your kind tryied to trick me with food.',
				'Popsy: ...look, we just want to find Chiquininín.',
				'Popsy: Maybe you know something about him?',
				'Roberto: Sorry, but...',
				'Gonorrein: Shut up you all! You have Chiquininín! Of course we are all sure.'
			]), 'completed')
			
			opt.turn_off()
		'Opt5':
			yield(E.run_cutscene([
				'Goddiu: Someone you fear told us what to do.',
				'Popsy: Oh yeah... someone from another planet.',
				'Roberto: WHAT!?',
				'Gonorrein: ' + Utils.say_in_popochiu('iiiiiiiii!', 'laughs'),
				'Roberto: Wait wait wait, we can come to an agreement.',
				'Trapusinsiu: To late Roberto, you missed your chance.',
				"Roberto: What? You didn't give me any choice.",
				'Gonorrein: F@@k you!'
			]), 'completed')
			
			Globals.in_roberto_dialog = true
			D.finish_dialog()
			return
		'Opt6':
			yield(E.run_cutscene([
				'Trapusinsiu: We are going to cry so loud that someone will hear us and will come to check what is happening.',
				'Goddiu: Good luck trying to explain why a bunch of Popochius are crying in the house of a naked Roberto!',
				'Roberto: Do it! No one will be able to hear your cries.'
			]), 'completed')
			
			opt.turn_off()
		'Opt7':
			yield(E.run_cutscene([
				'Goddiu: We will stay here blocking the exit until you get tired.',
				'Roberto: Go ahead, the more of you the better for me.',
				'Trapusinsiu(sad): Ayy dooooooooooooooo!'
			]), 'completed')
			
			opt.turn_off()
	
	_show_options()
