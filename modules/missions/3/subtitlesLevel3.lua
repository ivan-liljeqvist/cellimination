


function level3Subtitles()

	if GAME_TIME>level3State.VOICE2_START_TIME and not level3State.sub10 then
		msg.post("HUD","setSubtitleText",{text="THE RIBOSOME IS UNDER MY CONTROL!"})
		level3State.sub10=true
	elseif GAME_TIME>level3State.VOICE2_START_TIME+3.5 and not level3State.sub11 then
		msg.post("HUD","setSubtitleText",{text="We will use our protein gains to take\nthe virus into a new era!"})
		level3State.sub11=true
	elseif GAME_TIME>level3State.VOICE2_START_TIME+10 and not level3State.sub12 then
		msg.post("HUD","setSubtitleText",{text="*EVIL LAUGH*"})
		level3State.sub12=true
	elseif GAME_TIME>level3State.VOICE2_START_TIME+12 and not level3State.sub13 then
		msg.post("HUD","setSubtitleText",{text=""})
		level3State.sub13=true
		
	elseif level3State.VOICE3_START_TIME and GAME_TIME>level3State.VOICE3_START_TIME and not level3State.sub14 then
		msg.post("HUD","setSubtitleText",{text="Commander, as the viruses control RIBOSOME we cannot\nextract any protein at all!"})
		level3State.sub14=true
	elseif level3State.VOICE3_START_TIME and GAME_TIME>level3State.VOICE3_START_TIME+5.7 and not level3State.sub15 then
		msg.post("HUD","setSubtitleText",{text="The only way for us to get protein is to kill the viruses\nand collect the protein and they drop."})
		level3State.sub15=true
	elseif level3State.VOICE3_START_TIME and GAME_TIME>level3State.VOICE3_START_TIME+13 and not level3State.sub16 then
		msg.post("HUD","setSubtitleText",{text=""})
		level3State.sub16=true
		
	elseif level3State.VOICE4_START_TIME and GAME_TIME>level3State.VOICE4_START_TIME and not level3State.sub17 then
		msg.post("HUD","setSubtitleText",{text="AH! I can sense a big virus south of our camp."})
		level3State.sub17=true
		
	elseif level3State.VOICE4_START_TIME and GAME_TIME>level3State.VOICE4_START_TIME+4 and not level3State.sub18 then
		msg.post("HUD","setSubtitleText",{text="Exterminate it and we will get a lot of resources."})
		level3State.sub18=true
		
	elseif level3State.VOICE4_START_TIME and GAME_TIME>level3State.VOICE4_START_TIME+8.5 and not level3State.sub19 then
		msg.post("HUD","setSubtitleText",{text=""})
		level3State.sub19=true
	end

end


function level3SubtitlesIntro()


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
	elseif GAME_TIME>level3State.VOICE1_START_TIME+40 and not level3State.sub9 then
		msg.post("HUD","setSubtitleText",{text=""})
		level3State.sub9=true
		
		setPeaceOver()
	end

end