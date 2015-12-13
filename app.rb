require 'sinatra'
require 'json'
require 'open-uri'

# add at symbol to a name so slack recognizes
def add_at_symbol(string)
  if string.start_with?("@")
    return string
  else
    return string.prepend("@")
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



  # need to abstract this out if ever used with other teams
  di_slack_token = "xoxp-2151774549-4117477680-16044766884-54e7959db7"

  # make sure @poof_receiver is a slack user and formulate response message
  slack_api_call = "https://slack.com/api/users.list?token=#{di_slack_token}&pretty=1"
  raw_slack_data = open(slack_api_call).read
  parsed_slack_data = JSON.parse(raw_slack_data)
  slack_users = []
  parsed_slack_data["members"].each do |member|
    slack_users << member["name"]
  end

  if slack_users.include?(poof_receiver)
    add_at_symbol(poof_receiver)
    response_message = "#{poof_giver} gave #{poof_receiver} a :poof:!"
  else
    add_at_symbol(poof_receiver)
    response_message = "Oh no! #{poof_receiver}'s not a member of this slack team :dizzy_face:"
  end


  {:username => 'poofit', :response_type => "in-channel", :text => response_message }.to_json
end
