class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :rand_logic, only: :index
  require 'Logica'
  # GET /players
  # GET /players.json
  def index
    @m = Logica.start_engine
    @players = Player.all
    if @players.count > 0
      @players.each do |p|
        @rand_u = @probabilities[rand(0..99)]
        if @rand_u == @rand_pr
          p.update(money:1000)
          @winners << p
        else
          p.update(money:0)
          @losers << p
        end
      end
    end

  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end
    def rand_logic
      @roulette = ["Rojo", "Negro", "Verde"]
      @probabilities = []
      @winners = []
      @losers = []
      (0..99).each do |r|
        if r <= 47
          @probabilities << @roulette[0]
        elsif r > 47 && r <=97
          @probabilities << @roulette[1]
        else
          @probabilities << @roulette[2]
        end
      end
      @rand_pr = @probabilities[rand(0..99)]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :last_name, :age, :money)
    end
end
