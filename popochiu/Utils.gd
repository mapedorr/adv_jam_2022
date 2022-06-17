extends Node
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# I'm glad you are here.
# There's one more thing to do in the game. I will tell you how... you'll find
# to discover where.
# Make them happy, in this order:
# gd, gd, pp, tr, gn, ch, ch, gn, pp, tr, tr, gd, gd
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


static func say_in_popochiu(popochi: String, translation: String) -> String:
	return '%s\n[color=yellow](%s)[/color]' %\
	[E.get_text(popochi), E.get_text(translation)]
