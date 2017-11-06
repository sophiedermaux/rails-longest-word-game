class GamesController < ApplicationController
  require "open-uri"

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @included = included?(@letters, @word)
    @english_word = english_word?(@word)
    # if included?(@letters, @word)
    #  if english_word?(@word)
    #     return "congrats! that is an english word"
    #   else
    #     return "Sorry that isn't english"
    #   end
    # else
    #   return "Sorry that doesn't work"
    # end
  end

  def included?(letters, word)
    word = word.split("")
    word.all? {|letter| word.count(letter) <= letters.count(letter)}
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end

end
