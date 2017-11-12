require 'notification/notification'

require 'notis_config/notis_config'

require 'notis_engine/notis_engine'

class DayNotis
	def initialize(basePath)
		@basePath = basePath

		@config = NotisConfig.new(@basePath + "/config.yml")
		@notification = Notification.new(@basePath)

		@engine = NotisEngine.new(@config, @notification)

		# Mainloop entrypoint
		@engine.startEngine
	end
end
