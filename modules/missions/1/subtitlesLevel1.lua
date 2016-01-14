


function level1Subtitles()

	--TRACK1
	
	if GAME_TIME>level1State.VOICE1_START_TIME and not level1State.sub1 then
		msg.post("HUD","setSubtitleText",{text="The cells you see in front of you are a Patrol Squad."})
		level1State.sub1=true
	elseif GAME_TIME>level1State.VOICE1_START_TIME+2.3 and not level1State.sub2 then
		msg.post("HUD","setSubtitleText",{text="They have been deployed to inspect this area, due to reports of disturbances."})
		level1State.sub2=true
	elseif GAME_TIME>level1State.VOICE1_START_TIME+7 and not level1State.sub3 then
		msg.post("HUD","setSubtitleText",{text="The Headquarters of bodily defence, the mighty Immune System,\nhave chosen you to act commander of this squad."})
		level1State.sub3=true
	elseif GAME_TIME>level1State.VOICE1_START_TIME+13 and not level1State.sub4 then
		msg.post("HUD","setSubtitleText",{text="This is a great opportunity to prove you have what it takes\nto climb the ranks of the Immune System."})
		level1State.sub4=true
	elseif GAME_TIME>level1State.VOICE1_START_TIME+18 and not level1State.sub5 then
		msg.post("HUD","setSubtitleText",{text="Your mission is to scout the area using your troops,\nreporting any abnormalities back to the Headquarters."})
		level1State.sub5=true
	elseif GAME_TIME>level1State.VOICE1_START_TIME+24 and not level1State.sub6 then
		msg.post("HUD","setSubtitleText",{text=""})
		level1State.sub6=true
		
	--TRACK2
	
	elseif GAME_TIME>level1State.VOICE2_START_TIME and not level1State.sub7 then
		msg.post("HUD","setSubtitleText",{text="To begin the mission you will have to select the cells,\nby holding down the left mouse button and dragging\ndiagonally to create a green field surrounding the squad."})
		level1State.sub7=true
	elseif GAME_TIME>level1State.VOICE2_START_TIME+8 and not level1State.sub8 then
		msg.post("HUD","setSubtitleText",{text="Now, you have them all ready and awaiting your commands."})
		level1State.sub8=true
	elseif GAME_TIME>level1State.VOICE2_START_TIME+10.5 and not level1State.sub9 then
		msg.post("HUD","setSubtitleText",{text="You order your squad to move around by pressing the right mouse button.\nThey will then move to the selected spot.\nThese are the basic unit controls."})
		level1State.sub9=true
	elseif GAME_TIME>level1State.VOICE2_START_TIME+18 and not level1State.sub10 then
		msg.post("HUD","setSubtitleText",{text="Go ahead and search the area for anything unusual!"})
		level1State.sub10=true
		elseif GAME_TIME>level1State.VOICE2_START_TIME+22 and not level1State.sub11 then
		msg.post("HUD","setSubtitleText",{text=""})
		level1State.sub11=true
	
	
	
	--TRACK3
	elseif level1State.VOICE3_START_TIME and GAME_TIME>level1State.VOICE3_START_TIME and not level1State.sub12 then
		msg.post("HUD","setSubtitleText",{text="I can sense there are intruders nearby.\nSomething tells me there might be a minor virus infection."})
		level1State.sub12=true
	elseif level1State.VOICE3_START_TIME and GAME_TIME>level1State.VOICE3_START_TIME+4 and not level1State.sub13 then
		msg.post("HUD","setSubtitleText",{text="Viruses are hostile in nature and can be recognised by their purple colour."})
		level1State.sub13=true
	elseif level1State.VOICE3_START_TIME and GAME_TIME>level1State.VOICE3_START_TIME+9 and not level1State.sub14 then
		msg.post("HUD","setSubtitleText",{text="If you see one, you have to exterminate it or else it is going to do the same to you."})
		level1State.sub14=true
	elseif level1State.VOICE3_START_TIME and GAME_TIME>level1State.VOICE3_START_TIME+13 and not level1State.sub15 then
		msg.post("HUD","setSubtitleText",{text="You attack one by selecting your units\nand with the right mouse button clicking on the virus.\n\nBE ON YOUR GUARD!"})
		level1State.sub15=true
	elseif level1State.VOICE3_START_TIME and GAME_TIME>level1State.VOICE3_START_TIME+18 and not level1State.sub16 then
		msg.post("HUD","setSubtitleText",{text=""})
		level1State.sub16=true
		
	--TRACK4
	elseif  level1State.VOICE4_START_TIME and GAME_TIME>level1State.VOICE4_START_TIME and not level1State.sub17 then
		msg.post("HUD","setSubtitleText",{text="Well done, commander!\nThe Headquarters will be proud."})
		level1State.sub17=true
	elseif  level1State.VOICE4_START_TIME and GAME_TIME>level1State.VOICE4_START_TIME+3 and not level1State.sub18 then
		msg.post("HUD","setSubtitleText",{text="But remember, viruses rarely come alone.\nKeep moving forwards and expect encounters!"})
		level1State.sub18=true
	elseif level1State.VOICE4_START_TIME and GAME_TIME>level1State.VOICE4_START_TIME+8 and not level1State.sub19 then
		msg.post("HUD","setSubtitleText",{text=""})
		level1State.sub19=true
		
	--TRACK5
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME and not level1State.sub20 then
		msg.post("HUD","setSubtitleText",{text="COMMANDER! I am afraid the threat is on a whole different level than we expected."})
		level1State.sub20=true
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+3 and not level1State.sub21 then
		msg.post("HUD","setSubtitleText",{text="The viruses have come in outrageous numbers."})
		level1State.sub21=true
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+6 and not level1State.sub22 then
		msg.post("HUD","setSubtitleText",{text=" You have to turn back now!"})
		level1State.sub22=true
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+8 and not level1State.sub23 then
		msg.post("HUD","setSubtitleText",{text="Retreat to the starting point where you will\nrendezvous with an evacuation squad."})
		level1State.sub23=true
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+11 and not level1State.sub24 then
		msg.post("HUD","setSubtitleText",{text="Safety is no. 1 priority!"})
		level1State.sub24=true
	elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+15 and not level1State.sub25 then
		msg.post("HUD","setSubtitleText",{text="*EVIL LAUGH* MINIONS! ASSEMBLE YOUR FORCES! *EVIL LAUGH*"})
		level1State.sub25=true
		elseif  level1State.VOICE5_START_TIME and GAME_TIME>level1State.VOICE5_START_TIME+19 and not level1State.sub26 then
		msg.post("HUD","setSubtitleText",{text=""})
		level1State.sub26=true
	end
	
end
