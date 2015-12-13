require 'sinatra'
require 'json'
require 'open-uri'

post '/gateway' do

  return if params[:token] != 'LK1QyaEb4i9TGfd0Nb2adL8D'

  trigger_word = params[:trigger_word].strip
  poof_receiver = params[:text].gsub(trigger_word, '').strip
  poof_giver = params[:user_name].strip

  # make sure poof_receiver has @ symbol appended to front
  if poof_receiver.include? "@"
  else poof_receiver = poof_receiver.prepend("@")
  end


  # make sure @poof_receiver is a slack user and formulate response_message
  # case poof_receiver
  #   when ''
  #   else # default - ignore
  # end

  response_message = "#{poof_receiver} got a poof! :poof:\n(#{poof_receiver} now has x total poofs)"

  content_type :json
  {:username => 'poofit', :response_type => "in-channel", :text => response_message }.to_json
end
