class Setting < ActiveRecord::Base

	@@VarTypes = [['String', 0], ['Integer', 1], ['Boolean', 2]]

	STRING_TYPE = 0
	INT_TYPE 	= 1
	BOOL_TYPE 	= 2


	def stype
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
		self.class.save_all
	end

	class << self
		def get(name)
			record = self.get_cached[name]
			record ? record.casted_value : nil
		end

		def VarTypes
			@@VarTypes
		end

		def save_all
			save = {}

			self.all.each do |setting|
				save[setting.name] = setting
			end

			Rails.cache.write 'settings', save
			save
		end

		def get_cached
			return self.save_all if !Rails.cache.exist? 'settings'

			return Rails.cache.read 'settings'
		end
	end
end
