class SettingsController < ApplicationController
  layout 'left-column'
  before_action :authenticate_user!
  before_action :require_admin!


  FAILED_SAVE_MSG = 'Unable to save settings'

  # GET /settings
  # GET /settings.json
  def index
  end


  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    if !valid_settings_params?
      flash[:error] = 'Encountered some suspicious data'
      return render :index 
    end

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          settings_params.each do |setting_params|
            name = setting_params.shift

            setting = Setting.where(name: name).first_or_initialize
            setting.var_type = permitted_settings[name.to_sym] if setting.new_record?
            setting.value = setting_params.shift

            # setting.update(value: settings_params.shift)
            # setting = Setting.new(name: name, value: setting_params.shift, var_type: permitted_settings[name.to_sym])

            setting.save!
          end
        end
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error] = FAILED_SAVE_MSG
        
        format.html { render :index }
        format.json { render json: FAILED_SAVE_MSG, status: :unprocessable_entity }
      end

      Setting.update_cache
      format.html { redirect_to settings_url, notice: 'Setting was successfully updated.' }
      format.json { render :index, status: :ok, location: settings_url }
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def valid_settings_params?
      logger.debug permitted_settings.keys - settings_params.keys
      return false if (permitted_settings.keys - settings_params.keys).count > 0
      true
    end

    def settings_params
      parameters = params.require(:setting).inject({}){ |memo,(k,v)| memo[k.to_sym] = v; memo }

      if !parameters.has_key? :debug
        parameters[:debug] = false
      end

      parameters
    end

    def permitted_settings
      {
        virtual_hosts_path: Setting::STRING_TYPE,
        default_user_shell: Setting::STRING_TYPE,
        server_admin: Setting::STRING_TYPE,
        debug: Setting::BOOL_TYPE
      }
    end
end
