require 'yaml'

require 'notis_config/notis_config_item'

class NotisConfig
	attr_reader :config

	def initialize(configPath)
		@configPath = configPath
		reloadConfig
	end

	def reloadConfig
		raise "Config not found!" if not foundConfigFile?
		@config = YAML.load_file @configPath
		return
	end

	def getDayItems(day)
		day = day.upcase
		raise "Day not found in config!" if not @config[day]
		return @config[day].map do |time, obj|
			NotisConfigItem.new(time, obj)
		end
	end

	private
	def foundConfigFile?
		return false if not File.exist?(@configPath)	
		return false if not File.file?(@configPath)	
		return true
	end
end

