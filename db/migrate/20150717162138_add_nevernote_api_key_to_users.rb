class AddNevernoteApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nevernote_api_key, :string
  end
end
