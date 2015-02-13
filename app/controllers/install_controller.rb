class InstallController < ApplicationController
  layout "middle-column"




  def start
		if is_installed?
			return redirect_to new_user_session_path, error: 'Please don\'t this path is no longer available'
		end

		@user = User.new
  end

  def install
  	@user = User.new(user_params)
  	if !valid_settings_params?
  		flash[:error] = 'Encountered a suspicious data'
  		return render :start 
  	end

  	begin
	  	ActiveRecord::Base.transaction do
		  	@user.is_admin = true
		  	@user.confirmed_at = DateTime.now
		  	@user.save!

				settings_params.each do |setting_params|
					name = setting_params.shift

					setting = Setting.new(name: name, value: setting_params.shift, var_type: permitted_settings[name.to_sym])
					setting.save!
				end

				installed = Setting.new(name: 'installed', value: true, var_type: Setting::BOOL_TYPE)
				installed.save!
			end
		rescue ActiveRecord::RecordInvalid => invalid
			return render :start, error: 'Unable to complete installation'
		end

		Setting.update_cache
		redirect_to new_user_session_path, success: 'You\'ve completed the installation process.'
  end


  private
  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
  	end

  	def valid_settings_params?
  		logger.debug permitted_settings.keys - settings_params.keys
  		return false if (permitted_settings.keys - settings_params.keys).count > 0
  		true
  	end

  	def settings_params
  		params.require(:setting).inject({}){ |memo,(k,v)| memo[k.to_sym] = v; memo }
  	end

  	def permitted_settings
  		{
  			virtual_hosts_path: Setting::STRING_TYPE,
  			default_user_shell: Setting::STRING_TYPE,
  			server_admin: Setting::STRING_TYPE
  		}
  	end
  
end
