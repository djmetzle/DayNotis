class NotisEngineTime
	attr_reader :dayName

	def initialize
		# The last notification tracked as ran
		@lastTime = {:day => 'SUNDAY', :hour => 0, :minute => 0}
		puts "Engine"
	end

	def updateTime
		@timeNow = DateTime.now
		@dayName = @timeNow.strftime('%^A')
		return
	end

	# is it the same time as the last time?
	def sameTime?
		dayMatch = (@lastTime[:day] == @dayName)
		hourMatch = (@lastTime[:hour] == @timeNow.hour)
		minuteMatch = (@lastTime[:minute] == @timeNow.minute)
		dayMatch and hourMatch and minuteMatch
	end

	def setLastTime
		@lastTime[:day] = dayName
		@lastTime[:hour] = @timeNow.hour
		@lastTime[:minute] = @timeNow.minute
		return
	end

	def currentItems(items)
		currentItems = items.select do |item|
			itemTimeMatch?(item, @timeNow)
		end
		return currentItems.first
	end

	private
	def itemTimeMatch?(item, time)
		hourMatch = (item.hour == time.hour)
		minuteMatch = (item.minute == time.minute)
		hourMatch and minuteMatch
	end


end
