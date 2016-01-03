--sound effects have variations, for example slime1, slime2
NUMBER_OF_VARIATIONS={}
NUMBER_OF_VARIATIONS["slime"]=2

--store the just played id of each sound effect
OLD_PLAYED_IDS={}
OLD_PLAYED_IDS["slime"]=""


function playSoundEffect(soundEffectId)

		if ENABLE_SOUND == false then return end
		if ENABLE_SOUND_EFFECTS == false then return end

		local variationNumber = math.random(1, NUMBER_OF_VARIATIONS[soundEffectId])
		local newSoundId ="#"..soundEffectId..variationNumber
		
		
		if OLD_PLAYED_IDS[soundEffectId]~=newSoundId then
			msg.post(OLD_PLAYED_IDS[soundEffectId], "stop_sound")
			msg.post(newSoundId, "play_sound", {delay = 0, gain = 0.2})
		else
			msg.post(newSoundId, "play_sound", {delay = 0, gain = 0.2})
		end
		
		
		OLD_PLAYED_IDS[soundEffectId]=newSoundId
		
		CAN_PLAY_SOUND_EFFECTS=false
end





function checkIfCanPlaySFX(dt)
	--now we can't play, but last time we could, see if 1 second has passed
	if CAN_PLAY_SOUND_EFFECTS==false and LAST_CAN_PLAY_SOUND_EFFECTS==true then
		sinceLastTimeSoundEffects=sinceLastTimeSoundEffects+dt
		
		if sinceLastTimeSoundEffects >= 1 then
			LAST_CAN_PLAY_SOUND_EFFECTS=true
			CAN_PLAY_SOUND_EFFECTS=true
			sinceLastTimeSoundEffects=0
		end
	end
end

function startMainBackgroundMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
    	msg.post("#battle", "play_sound", {delay = 0, gain = 0.2})
    end
end

function startSoundscapeMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
    	msg.post("#soundscape", "play_sound", {delay = 0, gain = 0.5})
    end
end

function startBackgroundMusic()
	if ENABLE_SOUND and ENABLE_MUSIC then
    	msg.post("#calm", "play_sound", {delay = 0, gain = 0.5})
    end
end