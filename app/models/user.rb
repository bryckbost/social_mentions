require "net/http"

class User
  include MongoMapper::Document

  key :full_name,           String
  key :email,               String
  key :github_uid,          String
  key :name,                String
  key :token,               String
  key :gravatar_token,      String
  key :github_access_token, String
  timestamps!
  
  def self.from_omniauth!(omniauth)
    info = omniauth["info"]
    extra = omniauth.fetch("extra", {}).fetch("raw_info", {})

    find_or_initialize_by_github_uid(omniauth["uid"].to_s).tap do |user|
      user.github_access_token = omniauth["credentials"]["token"]
      user.full_name = info["name"].presence || info["nickname"].presence
      user.email = info["email"].presence || user.emails.first
      user.name = info["nickname"]
      user.gravatar_token = User.gravatar_token(extra)
      user.save!
    end
  end

  def self.gravatar_token(remote)
    return remote["gravatar_id"] if remote["gravatar_id"]
    uri = URI.parse(remote["avatar_url"])
    raise unless uri.host =~ /gravatar\.com$/
    uri.path.match(/^\/avatar\/([0-9a-f]+)$/)[1]
  rescue
    nil
  end

  def github
    @github ||= Octokit::Client.new(:oauth_token => github_access_token)
  end

end