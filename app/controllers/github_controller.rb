class GithubController < ApplicationController
	#this controller displays the current user repos
	#pull the list of all public repos for the current user
	#first authenticate the client with access token stored in GithubProfile model
	#after that query the user repos with the client.repos
  def index
  	client= Octokit::Client.new(:access_token => current_user.github_profile.access_token)
  	@repositories = client.repos
  end
end
