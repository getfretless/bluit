class Nevernote
  include HTTParty
  include Singleton

  API_BASE = Rails.application.secrets['nevernote_api_base']
  API_KEY = Rails.application.secrets['nevernote_api_key']

  base_uri API_BASE

  def self.find(id)
    get "/notes/#{id}?api_key=#{API_KEY}"
  end

  def self.create_from(post)
    content = post.link.presence || post.body
    post "/notes",
      body: {
        api_key: API_KEY,
        note: {
          title: post.title,
          body_html: content
        }
      }
  end
end
