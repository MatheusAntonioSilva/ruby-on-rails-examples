require 'json'

class ApplicationController

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def hello_word
    'Hello World!'
  end
end
