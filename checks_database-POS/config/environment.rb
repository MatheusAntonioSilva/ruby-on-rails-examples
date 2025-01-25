require 'sinatra'
require 'bundler'
require 'sinatra/activerecord'
require 'pry'
require 'pry-remote'

Bundler.require

db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(db_options['development'])

require_all 'app'
require_all 'config'
require_all 'lib'
