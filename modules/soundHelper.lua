
ENABLE_SOUND=true
ENABLE_MUSIC=true
ENABLE_SOUND_EFFECTS=true


--sound effects have variations, for example slime1, slime2
NUMBER_OF_VARIATIONS={}

NUMBER_OF_VARIATIONS["workerCall"]=4
NUMBER_OF_VARIATIONS["workerResponse"]=4
NUMBER_OF_VARIATIONS["tankCall"]=4
NUMBER_OF_VARIATIONS["tankResponse"]=4
NUMBER_OF_VARIATIONS["soldierCall"]=4
NUMBER_OF_VARIATIONS["soldierResponse"]=4
NUMBER_OF_VARIATIONS["healerCall"]=4
NUMBER_OF_VARIATIONS["healerResponse"]=4
NUMBER_OF_VARIATIONS["deathVoice"]=2

--store the just played id of each sound effect
OLD_PLAYED_IDS={}


function playSoundEffect(soundEffectId)

		
		if ENABLE_SOUND == false then return end
		if ENABLE_SOUND_EFFECTS == false then return end

		local variationNumber = math.random(1, NUMBER_OF_VARIATIONS[soundEffectId])
		local newSoundId ="#"..soundEffectId..variationNumber
		
		local gain=0.15
		if BACKGROUND_LOWERED then gain=0.02 end
		
		if OLD_PLAYED_IDS[soundEffectId]~=newSoundId then
			msg.post(OLD_PLAYED_IDS[soundEffectId], "stop_sound")
			
			
			msg.post(newSoundId, "play_sound", {delay = 0, gain =gain})
		else
			msg.post(newSoundId, "play_sound", {delay = 0, gain = gain})
		end
		
		
		OLD_PLAYED_IDS[soundEffectId]=newSoundId
		
		CAN_PLAY_SOUND_EFFECTS=false
end





function checkIfCanPlaySFX(dt)
	--now we can't play, but last time we could, see if 1 second has passed
	if CAN_PLAY_SOUND_EFFECTS==false and LAST_CAN_PLAY_SOUND_EFFECTS==true then
		sinceLastTimeSoundEffects=sinceLastTimeSoundEffects+dt
		
		if sinceLastTimeSoundEffects >= 1.5 then
			LAST_CAN_PLAY_SOUND_EFFECTS=true
			CAN_PLAY_SOUND_EFFECTS=true
			sinceLastTimeSoundEffects=0
		end
	end
end


function startBattleBackgroundMusic()

	if ENABLE_SOUND and ENABLE_MUSIC then
		
		msg.post("#battle","play_sound", {delay = 0, gain = 0.3})
		
		sound.set_group_gain("main",0.0)
    	sound.set_group_gain("battle",1)
    	BATTLE_MODE=true
    end
    
end

function startVictoryMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
	
		if BATTLE_MODE then
			--msg.post("#battle", "stop_sound")
			sound.set_group_gain("battle",0.0)
		else
			--msg.post("#main", "stop_sound")
			sound.set_group_gain("main",0.0)
		end
		
		msg.post("#victory", "play_sound", {delay = 0, gain = 0.2})
	
	end
end

function startDefeatMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
	
	
		if BATTLE_MODE then
			--msg.post("#battle", "stop_sound")
			sound.set_group_gain("battle",0.0)
		else
			--msg.post("#main", "stop_sound")
			sound.set_group_gain("main",0.0)
		end
		
		msg.post("#defeat", "play_sound", {delay = 0, gain = 0.2})
	
	end
end


function startMainBackgroundMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
	
		print("STARR T BG MUSK!")
	
		msg.post("#roamingUnit1","play_sound", {delay = 0, gain = 0.0})
		msg.post("#roamingUnit2","play_sound", {delay = 0, gain = 0.0})
    	msg.post("#main", "play_sound", {delay = 0, gain = 0.5})
    	msg.post("#roamingUnit3","play_sound", {delay = 0, gain = 0.0})
    	msg.post("#roamingUnit4","play_sound", {delay = 0, gain = 0.0})
    	
    	sound.set_group_gain("main",1)
    	sound.set_group_gain("battle",0)
    end
end

function startSoundscapeMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
    	msg.post("#soundscape", "play_sound", {delay = 0, gain = 0.5})
    end
end



function playCallSound(unitName)
	if unitName == WORKER_NAME and ENABLE_SOUND then
		msg.post("mixer","workerCall",{})
	elseif unitName == TANK1_NAME and ENABLE_SOUND then
		msg.post("mixer","tankCall",{})
	elseif unitName == SOLDIER_NAME and ENABLE_SOUND then
		msg.post("mixer","soldierCall",{})
	elseif unitName == HEAL1_NAME then
		msg.post("mixer","healerCall",{})
	end
end

function playResponseSound(unitName)
	if unitName == WORKER_NAME and ENABLE_SOUND then
		msg.post("mixer","workerResponse",{})
	elseif unitName == TANK1_NAME and ENABLE_SOUND then
		msg.post("mixer","tankResponse",{})
	elseif unitName == SOLDIER_NAME and ENABLE_SOUND then
		msg.post("mixer","soldierResponse",{})
	elseif unitName == HEAL1_NAME and ENABLE_SOUND then
		msg.post("mixer","healerResponse",{})
	end
end