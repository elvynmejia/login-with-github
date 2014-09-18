class User < ActiveRecord::Base
	#Associate each profile with its user
	has_one :github_profile

  def self.create_with_omniauth(auth)
    new_user= create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end

  	new_user.create_github_profile auth

  	new_user
  end

  def create_github_profile auth
  	GithubProfile.create({user_id: id, nickname: auth[:info][:nickname]|| "", 
  		email: auth[:info][:email]||"", name: auth[:info][:name]||"",
  		image: auth[:info][:image]||"", 
  		location: auth[:extra][:raw_info][:location]||"", 
  		public_repo: auth[:extra][:raw_info][:public_repos]||"",
  		public_gists: auth[:extra][:raw_info][:public_gists]||"",
  		followers: auth[:extra][:raw_info][:followers]||"",
  		following: auth[:extra][:raw_info][:following]||"",
  		member_since: auth[:extra][:raw_info][:created_at]||"",
  		access_token: auth[:credentials][:token]
  		})
  end 
end
