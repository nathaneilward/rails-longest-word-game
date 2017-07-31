class LongestGameController < ApplicationController
  def game
    @grid = generate_grid(9)
    $start_time = Time.now

    # $end_time =
  end

  # VARIABLE SCOPE

  # @var = available for instance, only available inside the method and on the corresponding view
  # @@var = class method, available constant throughout multiple instances of the class
  # $var = global var, available throughout the entire app! woop woop


  def score
    attempt = params[:attempt]
    grid = params.fetch(:grid).split(",") if params[:grid]
    start_time = $start_time
    end_time = Time.now
    @result = run_game(attempt, grid, start_time, end_time)
    # @score_and_message = score_and_message(attempt, grid, result[:time])
    # @compute_score = compute_score(attempt, time_taken)
    # @score_and_message = score_and_message(attempt, grid, time)
  end


  private

  def generate_grid(grid_size)
    array = []
    grid_size.times do
      array << ('A'..'Z').to_a.sample
    end
    array
  end


  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end

  def run_game(attempt, grid, start_time, end_time)
    result = { time: end_time - start_time }
    @score_and_message = score_and_message(attempt, grid, result[:time])
    result[:score] = @score_and_message.first
    result[:message] = @score_and_message.last
    result
  end

  def score_and_message(attempt, grid, time)
    if included?(attempt.upcase, grid)
      [0, "good guess bro"]
    else
      [0, "not in the grid"]
    end
  end
end






# def english_word?(word)
#   response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#   json = JSON.parse(response.read)
#   return json['found']
# end
