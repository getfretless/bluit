class Nevernote
  include HTTParty
  include Singleton

  API_BASE = Rails.application.secrets['nevernote_api_base']

  base_uri API_BASE

  def self.find(id, api_key)
    get "/notes/#{id}?api_key=#{api_key}"
  end

  def self.create_from(post, api_key)
    post "/notes",
      body: {
        api_key: api_key,
        note: {
          title: post.title,
          body_html: post.link.presence || post.body
        }
      }
  end
end
