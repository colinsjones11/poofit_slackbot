require 'sinatra'
require 'json'

post '/gateway' do

  return if params[:token] != ENV['SLACK_TOKEN']

  trigger_word = params[:trigger_word].strip
  message = params[:text].gsub(trigger_word, '').strip
  user_name = params[:user_name].strip

  #switch on the message
  # case user_name
  #   when ''
  #   else # default - ignore
  # end

  response_message = "#{user_name} got a poof! :poof:"  #default response

  content_type :json
  {:username => 'poofit', :response_type => "in-channel", :text => response_message }.to_json
end
