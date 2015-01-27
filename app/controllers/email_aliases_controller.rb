class EmailAliasesController < ApplicationController
  layout 'left-column'
  before_action :authenticate_user!
  before_action :set_email_alias, only: [:show, :edit, :update, :destroy]

  # GET /email_aliases
  # GET /email_aliases.json
  def index
    @email_aliases = EmailAlias.all
  end

  # GET /email_aliases/1
  # GET /email_aliases/1.json
  def show
  end

  # GET /email_aliases/new
  def new
    @email_alias = EmailAlias.new
  end

  # GET /email_aliases/1/edit
  def edit
  end

  # POST /email_aliases
  # POST /email_aliases.json
  def create
    @email_alias = EmailAlias.new(email_alias_params)

    respond_to do |format|
      if @email_alias.save
        format.html { redirect_to @email_alias, notice: 'Email alias was successfully created.' }
        format.json { render :show, status: :created, location: @email_alias }
      else
        format.html { render :new }
        format.json { render json: @email_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_aliases/1
  # PATCH/PUT /email_aliases/1.json
  def update
    respond_to do |format|
      if @email_alias.update(email_alias_params)
        format.html { redirect_to @email_alias, notice: 'Email alias was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_alias }
      else
        format.html { render :edit }
        format.json { render json: @email_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_aliases/1
  # DELETE /email_aliases/1.json
  def destroy
    @email_alias.destroy
    respond_to do |format|
      format.html { redirect_to email_aliases_url, notice: 'Email alias was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_alias
      @email_alias = EmailAlias.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_alias_params
      params.require(:email_alias).permit(:domain_id, :source, :destination)
    end
end
