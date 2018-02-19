require 'open-uri'

class GameController < ApplicationController
  def new
    @letters = Array.new(12) { ("A".."Z").to_a.sample }
  end

 def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @in_dictionary = in_dictionary?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def in_dictionary?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
