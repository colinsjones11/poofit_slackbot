require 'sinatra'
require 'json'

post '/gateway' do
  trigger_word = params[:trigger_word].strip
  message = params[:text].gsub(trigger_word, '').strip

  #switch on the message
  # case message
  #   when 'hello'
  #   else # default - ignore
  # end

  response_message = "Here's a poof! :poof:"  #default response

  content_type :json
  {:username => 'poofit', :response_type => "in-channel", :text => response_message }.to_json
end
