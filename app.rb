require 'sinatra'
require 'json'
require 'open-uri'

# add at symbol to a name so slack recognizes
def add_at_symbol(string)
  if string.start_with?("@")
    else string.prepend("@")
  end
end

# listening on '/gateway' - defined in slack webhook config and heroku
post '/gateway' do

  # need to move this to an env variable
  return if params[:token] != 'LK1QyaEb4i9TGfd0Nb2adL8D'

  # parsing out slack message components
  trigger_word = params[:trigger_word].strip
  poof_giver = params[:user_name].strip
  poof_receiver = params[:text].gsub(trigger_word, '').strip


  # make sure @poof_receiver is a slack user and formulate response message
  di_slack_token = "xoxp-2151774549-4117477680-16044766884-54e7959db7"
  slack_api_call = "https://slack.com/api/users.list?token=#{di_slack_token}&pretty=1"
  raw_slack_data = open(slack_api_call).read
  parsed_slack_data = JSON.parse(raw_slack_data)
  slack_users = []
  parsed_slack_data["members"].each do |member|
    slack_users << member["name"]
  end

  if slack_users.include?(poof_receiver)
    poof_receiver.add_at_symbol
    response_message = "#{poof_receiver} got a poof! :poof:\n(#{poof_receiver} now has x total poofs)"
  else
    poof_receiver.add_at_symbol
    response_message = "#{poof_receiver} is not a member of this slack team :dizzy_face:"
  end


  {:username => 'poofit', :response_type => "in-channel", :text => response_message }.to_json
end
