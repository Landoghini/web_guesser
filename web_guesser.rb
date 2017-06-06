require 'sinatra'
require 'sinatra/reloader'
require 'erb'
enable :sessions


def check_guess(guess)
	if guess.to_i > session[:number]
		"Too high"
	elsif guess.to_i == session[:number]
		"You've guessed correctly, THE SECRET NUMBER is #{session[:number]}"
	elsif guess == nil
		''
	else
		"Too low"
	end
end


get '/reset' do
	session[:number] = rand(101)
	redirect '/'
end

get '/' do
	number = session[:number]
	guess = params["guess"]
	message = check_guess(guess)
	erb :index, :locals => { :number => number, :message => message}
end