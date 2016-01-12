

function level2Subtitles()

	--EVIL VOIDE
	
	if level2State.VOICE5_START_TIME and GAME_TIME>level2State.VOICE5_START_TIME and not level2State.sub28 then
		msg.post("HUD","setSubtitleText",{text="Minions! Attack their base!\nAND TAKE ALL THEIR GAINS!"})
		level2State.sub28=true
	elseif level2State.VOICE5_START_TIME and GAME_TIME>level2State.VOICE5_START_TIME+6 and not level2State.sub29 then
		msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub29=true
	
	elseif level2State.VOICE6_START_TIME and GAME_TIME>level2State.VOICE6_START_TIME and not level2State.sub30 then
		msg.post("HUD","setSubtitleText",{text="Hello Commander! I'm your engineer."})
		level2State.sub30=true
	elseif level2State.VOICE6_START_TIME and GAME_TIME>level2State.VOICE6_START_TIME+2.8 and not level2State.sub31 then
		msg.post("HUD","setSubtitleText",{text="Remember that you can always build an RnD structure."})
		level2State.sub31=true
	elseif level2State.VOICE6_START_TIME and GAME_TIME>level2State.VOICE6_START_TIME+6.3 and not level2State.sub32 then
		msg.post("HUD","setSubtitleText",{text="The RnD structure will allow you to upgrade your units."})
		level2State.sub32=true
	elseif level2State.VOICE6_START_TIME and GAME_TIME>level2State.VOICE6_START_TIME+11 and not level2State.sub33 then
		msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub33=true
		
	end

end


function level2SubtitlesIntroduction()

	--TRACK1
	
	if GAME_TIME>level2State.VOICE1_START_TIME and not level2State.sub1 then
		msg.post("HUD","setSubtitleText",{text="The Immune System is doing everything in their power\nto assemble all forces possible"})
		level2State.sub1=true
	elseif GAME_TIME>level2State.VOICE1_START_TIME+4 and not level2State.sub2 then
		msg.post("HUD","setSubtitleText",{text="in order to put an end to the viruses."})
		level2State.sub2=true
	elseif GAME_TIME>level2State.VOICE1_START_TIME+6.1 and not level2State.sub3 then
		msg.post("HUD","setSubtitleText",{text="They have chosen you to gather the resources\nrequired to build an army."})
		level2State.sub3=true
	elseif GAME_TIME>level2State.VOICE1_START_TIME+10 and not level2State.sub4 then
		msg.post("HUD","setSubtitleText",{text="Your objective is to gather 1000 of each\nresource possible in this area."})
		level2State.sub4=true
	elseif GAME_TIME>level2State.VOICE1_START_TIME+14 and not level2State.sub5e then
		msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub5e=true
	
	
	--TRACK2
	elseif GAME_TIME>level2State.VOICE2_START_TIME and not level2State.sub5 then
		msg.post("HUD","setSubtitleText",{text="In front of you, you have a worker unit\nand a Central Marrow structure."})
		level2State.sub5=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+4 and not level2State.sub6 then
		msg.post("HUD","setSubtitleText",{text="These are under your command."})
		level2State.sub6=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+6 and not level2State.sub7 then
		msg.post("HUD","setSubtitleText",{text="The worker is the Red Blood Cell\nand has come through the Central Marrow to help you."})
		level2State.sub7=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+10 and not level2State.sub8 then
		msg.post("HUD","setSubtitleText",{text="The Central Marrow can supply you with workers."})
		level2State.sub8=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+13.5 and not level2State.sub9 then
		msg.post("HUD","setSubtitleText",{text="The resources you need to keep track of are\nFAT, PROTEIN and CARBS."})
		level2State.sub9=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+17.5 and not level2State.sub10 then
		msg.post("HUD","setSubtitleText",{text="You can see your current resources at the top left of the screen."})
		level2State.sub10=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+21 and not level2State.sub11 then
		msg.post("HUD","setSubtitleText",{text="To create a resource income you will have to select the\nworker unit and build the three different EXTRACTORS."})
		level2State.sub11=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+27 and not level2State.sub12 then
		msg.post("HUD","setSubtitleText",{text="You build these by placing them on the brighter region\nof the ground, in the middle of the map."})
		level2State.sub12=true
	elseif GAME_TIME>level2State.VOICE2_START_TIME+32 and not level2State.sub13 then
		msg.post("HUD","setSubtitleText",{text="This region is nutrient-rich tissue."})
		level2State.sub13=true	
	elseif GAME_TIME>level2State.VOICE2_START_TIME+35 and not level2State.sub14 then
		msg.post("HUD","setSubtitleText",{text="The extractor will start to gather resources once you\norder the worker to move inside it."})
		level2State.sub14=true	
	elseif GAME_TIME>level2State.VOICE2_START_TIME+40 and not level2State.sub15 then
		msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub15=true	
		
		
	--TRACK3
	elseif level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME and not level2State.sub16 then
	 
	 	msg.post("HUD","setSubtitleText",{text="Now you have a stable resource income.\nAll you need to establish a proper defense now is to build a Replication Station."})
		level2State.sub16=true	
	
	elseif level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME+7 and not level2State.sub17 then
	 
	 	msg.post("HUD","setSubtitleText",{text="The replication station is represented by two crossed swords."})
		level2State.sub17=true	
	
	elseif level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME+10.5 and not level2State.sub18 then
	 
	 	msg.post("HUD","setSubtitleText",{text="Command a worker to build this."})
		level2State.sub18=true	
		
	elseif level2State.VOICE3_START_TIME and GAME_TIME>level2State.VOICE3_START_TIME+13.5 and not level2State.sub18extra and not level2State.sub19 then
	 
	 	msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub18extra=true	
		
		
	--TRACK4
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME and not level2State.sub19 then
	 	msg.post("HUD","setSubtitleText",{text="The Replication Station is where you\nare able to spawn battle units."})
		level2State.sub19=true	
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+4 and not level2State.sub20 then
	 	msg.post("HUD","setSubtitleText",{text="There are three units available to you."})
		level2State.sub20=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+6.5 and not level2State.sub21 then
	 	msg.post("HUD","setSubtitleText",{text="The White Blood Cells are offensive units,"})
		level2State.sub21=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+9 and not level2State.sub22 then
	 	msg.post("HUD","setSubtitleText",{text="the blue cells, the Monocytes are defensive units\nwith higher health than White Cells"})
		level2State.sub22=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+13.5 and not level2State.sub23 then
	 	msg.post("HUD","setSubtitleText",{text="and the green Stem Cells are supportive units that are able\n to heal units and structures."})
		level2State.sub23=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+19.5 and not level2State.sub24 then
	 	msg.post("HUD","setSubtitleText",{text="Brief descriptions and costs of all commands can be found\nby pointing at the various build icons."})
		level2State.sub24=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+24.5 and not level2State.sub25 then
	 	msg.post("HUD","setSubtitleText",{text="Now hurry up and gather a thousand of each resource! "})
		level2State.sub25=true
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+27.5 and not level2State.sub26 then
	 	msg.post("HUD","setSubtitleText",{text="Make sure you are prepared for battle.\nWe expect the viruses to do anything to stop us!"})
		level2State.sub26=true
	
	elseif level2State.VOICE4_START_TIME and GAME_TIME>level2State.VOICE4_START_TIME+32 and not level2State.sub27 then
	 	msg.post("HUD","setSubtitleText",{text=""})
		level2State.sub27=true
	end

end