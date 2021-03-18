class PlayersController < ApplicationController

  @@session_number = 0

  @@max_score = 0

  def index
    @player = Player.all
  end

  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to players_path
  end

  def update
    @Player = Player.find(params[:id])

    @player.update(post_params)

  end

  def simulate
    @kaggle_number = 10
    @player = Player.all

    if @@session_number == 3

      @player.each do |pers|
        if pers.score == @@max_score
          pers.update(winner: true)
        else
          pers.update(winner: false)
        end
      end

      self.reset()

    else

      @@session_number += 1
      @player.each do |pers|
        strikes = rand(0..@kaggle_number)

        strikes = pers.score + strikes
        pers.update(score: strikes)

        if pers.score > @@max_score
          @@max_score = pers.score
        end

      end
      redirect_to players_path

    end
  end

  def reset
    @player = Player.all
    @@session_number = 0
    @@max_score = 0

    @player.each do |pers|
      pers.update(score: 0)
    end

    redirect_to players_path
  end

  private def player_params
    params.require(:player).permit(:name, :score)
  end
end
