require 'notis_engine/notis_engine_time'

class NotisEngine
	def initialize(config, notification)
		@config = config
		@notification = notification

		@engineTime = NotisEngineTime.new

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
		@engineTime.updateTime
		return if @engineTime.sameTime?

		return if not updateConfig?

		updateItems

		return if not @currentItem

		# if we've gotten here, the current item from the current
		# config has not yet been run
		showNotification
	end

	def updateConfig?
		begin
			@config.reloadConfig
		rescue RuntimeError
			@notification.display("Notis Config Error")
			# only warn about config errors once per minute
			@engineTime.setLastTime
			return false
		end
		return true
	end

	def updateItems
		@items = @config.getDayItems(@engineTime.dayName)
		@currentItem = @engineTime.currentItems(@items).first
	end

	def showNotification
		title = @currentItem.title
		body = @currentItem.body
		level = @currentItem.level
		@notification.display(title, body, level)
		@engineTime.setLastTime
	end
end

