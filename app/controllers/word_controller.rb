require 'open-uri'
require 'json'

class WordController < ApplicationController

  def game
  end

  def score
    @suggestion = params[:query]
    @array = params[:array].split(" ")
    @time = params[:time]
    @translation = jsonparse(@suggestion)
    @wrong = not_english(@translation)
  end

  private

  def jsonparse(word)
    api_key = "59dcc952-bf84-4137-99ea-ee03d47f0c65"
    file = open("https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=#{api_key}&input=#{word}")
    json = JSON.parse(file.read.to_s)
    if json['outputs'] && json['outputs'][0] && json['outputs'][0]['output'] && json['outputs'][0]['output'] != word
      return json['outputs'][0]['output']
    end
  end

  def not_english(word)
    if word.nil?
      "NOT AN ENGLISH WORD"
    end
  end
end
