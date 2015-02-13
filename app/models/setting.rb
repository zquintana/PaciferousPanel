class Setting < ActiveRecord::Base

	@@VarTypes = [['String', 0], ['Integer', 1], ['Boolean', 2]]

	STRING_TYPE = 0
	INT_TYPE 	= 1
	BOOL_TYPE 	= 2


	def stype
		return 'nil' if self.var_type.nil?
		@@VarTypes[self.var_type][0]
	end

	def casted_value
		if self.var_type == INT_TYPE
			return self.value.to_i
		elsif self.var_type == BOOL_TYPE
			return self.value.to_bool
		end
			
		self.value
	end

	def after_save_cache
		self.class.update_cache
	end

	class << self
		def get(name, default=nil)
			record = self.get_cached[name]
			record ? record.casted_value : default
		end

		def add(name, value, type=STRING_TYPE)
			self.create(name: name, value: value, var_type: type)
		end

		def VarTypes
			@@VarTypes
		end

		def update_cache
			save = {}

			self.all.each do |setting|
				save[setting.name] = setting
			end

			Rails.cache.write 'settings', save
			save
		end

		def get_cached
			return self.update_cache if !Rails.cache.exist? 'settings'

			return Rails.cache.read 'settings'
		end
	end
end
