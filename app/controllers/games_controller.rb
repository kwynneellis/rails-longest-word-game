require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    word = params[:longestWord].capitalize
    @result = ''
    if find_word(word)
      @result = 'The word was found'
    else
      # TODO finish from here
      @result = 'Try again'
    end
  end

  def find_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def word_included_in_letters(word)
    word.all?
  end
end

# We want to handle three scenarios:

# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
