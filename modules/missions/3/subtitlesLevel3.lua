




function level3Subtitles()


	if GAME_TIME>level3State.VOICE1_START_TIME and not level3State.sub1 then
		msg.post("HUD","setSubtitleText",{text="With all the resources we have gathered, The Immune System\nhas taken the first big step towards fighting the viruses."})
		level3State.sub1=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+6 and not level3State.sub2 then
		msg.post("HUD","setSubtitleText",{text="Yet, I am afraid this is only the beginning.\nWe have a huge problem!"})
		level3State.sub2=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+10 and not level3State.sub3 then
		msg.post("HUD","setSubtitleText",{text="It seems that the main protein synthesizer,\nthe RIBOSOME, has been occupied by the viruses."})
		level3State.sub3=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+15 and not level3State.sub4 then
		msg.post("HUD","setSubtitleText",{text="Without access to it, it is impossible to extract protein\nwhich is paramount to our struggle for victory!"})
		level3State.sub4=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+21 and not level3State.sub5 then
		msg.post("HUD","setSubtitleText",{text="What is even more troublesome is that the viruses control the protein output."})
		level3State.sub5=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+25.5 and not level3State.sub6 then
		msg.post("HUD","setSubtitleText",{text="Viruses by nature, do not have RIBOSOMES, and\nwith it they might gain powers that we have never witnessed before."})
		level3State.sub6=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+31 and not level3State.sub7 then
		msg.post("HUD","setSubtitleText",{text="The RIBOSOME must be recaptured before the viruses\nreinforce the area or else it will be the end of us."})
		level3State.sub7=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+37.5 and not level3State.sub8 then
		msg.post("HUD","setSubtitleText",{text="Act quickly for this is a race against time!"})
		level3State.sub8=true
	elseif GAME_TIME>level3State.VOICE1_START_TIME+41 and not level3State.sub9 then
		msg.post("HUD","setSubtitleText",{text=""})
		level3State.sub9=true
		
		level3State.peaceOver=true
	end

end