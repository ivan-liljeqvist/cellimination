

level2State={}

level2State.FIRST_ATTACK_TIME=2
level2State.attacked=false


function level2Act()

	if GAME_TIME>level2State.FIRST_ATTACK_TIME and not level2State.attacked then
		msg.post("virusMind","attack")
		level2State.attacked=true
	end

end




function level2TriggerCheck(x,y)

	
end