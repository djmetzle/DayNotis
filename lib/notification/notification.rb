class Notification
	def initialize(basePath)
		@basePath = basePath
	end

	def display(message, body = nil, level = "notice")
		args = "\"#{message}\""
		if body
			args << " \"#{body}\""
		end
		`notify-send #{args}`
		if level == "urgent"
			chime
		end
		if level == "critical"
			bell
		end
	end

	def chime(sound = "chime.wav")
		path = @basePath + '/assets/' + sound
		`mplayer #{path}`
	end

	def bell(sound = "bell.wav")
		path = @basePath + '/assets/' + sound
		`mplayer #{path}`
	end
end
