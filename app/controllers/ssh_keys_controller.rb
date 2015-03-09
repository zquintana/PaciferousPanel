class SshKeysController < ApplicationController
  layout 'left-column'
  before_action :set_ssh_key, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /ssh_keys
  # GET /ssh_keys.json
  def index
    @ssh_keys = current_user.ssh_keys.all
  end

  # GET /ssh_keys/1
  # GET /ssh_keys/1.json
  def show
  end

  # GET /ssh_keys/new
  def new
    @ssh_key = current_user.ssh_keys.new
  end

  # GET /ssh_keys/1/edit
  def edit
  end

  # POST /ssh_keys
  # POST /ssh_keys.json
  def create
    @ssh_key = current_user.ssh_keys.new(ssh_key_params)

    respond_to do |format|
      if @ssh_key.save
        format.html { redirect_to ssh_keys_url, notice: 'Ssh key was successfully created.' }
        format.json { render :show, status: :created, location: @ssh_key }
      else
        format.html { render :new }
        format.json { render json: @ssh_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ssh_keys/1
  # PATCH/PUT /ssh_keys/1.json
  def update
    respond_to do |format|
      if @ssh_key.update(ssh_key_params)
        format.html { redirect_to edit_ssh_key_path(@ssh_key), notice: 'Ssh key was successfully updated.' }
        format.json { render :show, status: :ok, location: @ssh_key }
      else
        format.html { render :edit }
        format.json { render json: @ssh_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ssh_keys/1
  # DELETE /ssh_keys/1.json
  def destroy
    @ssh_key.destroy
    respond_to do |format|
      format.html { redirect_to ssh_keys_url, notice: 'Ssh key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ssh_key
      @ssh_key = current_user.is_admin? ? SshKey.find(params[:id]) : current_user.ssh_keys.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ssh_key_params
      params.require(:ssh_key).permit(:key, :descrip)
    end
end
