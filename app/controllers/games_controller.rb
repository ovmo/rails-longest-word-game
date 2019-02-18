require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @form_token = form_authenticity_token
  end

  def score
    # render plain: "Add to DB restaurant '#{params[:name]}'"
    @letters = params[:letters]
    @word = params[:word]
    dictionary = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(dictionary.read)
    @found = json['found']
    @exist = true
    @word.split('').each do |letter|
      @exist = false unless @letters.include?(letter.upcase) && @exist
    end
  end
end
