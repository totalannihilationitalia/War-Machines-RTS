-- Format: <tn> is replaced with actual team name


local messages = {
	'<tn> has been obliterated.',
-- ho rimosso tutti gli altri messaggi, rimetterli appena possibile
}

-- <side> is replaced by the the actual side.
local defaultmessages = {
	'<side> forces have gone to a better place.',
	'<side> vermin have been exterminated.',
	'<side> forces have been obliterated.',
}

-- <side> is replaced by the the actual side. In case a player resigns, the system has no information about the name
local resignedmessages = {
	'<side> forces have gone to a better place.',
	'<side> vermin have retreated',
	'<side> rascals have surrendered.',
	'<side> forces have laid down their arms.',
	'<side> rapscallions gave up',
	'<side> scoundrels have deserted',
	'<side> thugs ran away',
}

return messages, defaultmessages, resignedmessages

