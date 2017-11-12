

class NotisEngine
	def initialize(config, notification)
		@config = config
		@notification = notification

		@lastTime = {:day => 'SUNDAY', :hour => 0, :minute => 0}
	end

	def startEngine
		puts "Run mainloop"
		begin
			mainLoop
			sleep 10
		end while true
	end

	private
	def mainLoop
		updateTime
		return if sameTime?

		return if not updateConfig?

		updateItems

		return if not @currentItem
		return if hasBeenRun?

		# if we've gotten here, the current item from the current
		# config has not yet been run
		showNotification
	end

	def updateTime
		@timeNow = DateTime.now
		return
	end

	def updateConfig?
		begin
			@config.reloadConfig
		rescue RuntimeError
			@notification.display("Notis Config Error")
			setLastTime
			return false
		end
		return true
	end

	def updateItems
		dayName = @timeNow.strftime('%^A')
		@items = @config.getDayItems(dayName)
		updateCurrentItem
	end

	def updateCurrentItem
		items = @items.select do |item|
			itemTimeMatch?(item, @timeNow)
		end
		@currentItem = items.first
	end

	# helpers for time comparison
	def itemTimeMatch?(item, time)
		hourMatch = (item.hour == time.hour)
		minuteMatch = (item.minute == time.minute)
		hourMatch and minuteMatch
	end

	def sameTime?
		hourMatch = (@lastTime[:hour] == @timeNow.hour)
		minuteMatch = (@lastTime[:minute] == @timeNow.minute)
		hourMatch and minuteMatch
	end
	
	def hasBeenRun?
		# check for day rollover
		dayName = @timeNow.strftime('%^A')
		if @lastTime[:day] != dayName
			return false
		end

		hourMatch = (@currentItem.hour == @lastTime[:hour])
		minuteMatch = (@currentItem.minute == @lastTime[:minute])
		return (hourMatch and minuteMatch)
	end

	def setLastTime
		dayName = @timeNow.strftime('%^A')
		@lastTime[:day] = dayName
		@lastTime[:hour] = @timeNow.hour
		@lastTime[:minute] = @timeNow.minute
		return
	end

	def showNotification
		title = @currentItem.title
		body = @currentItem.body
		level = @currentItem.level
		@notification.display(title, body, level)
		setLastTime
	end
end

