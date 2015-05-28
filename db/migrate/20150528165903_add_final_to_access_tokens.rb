class AddFinalToAccessTokens < ActiveRecord::Migration
  def change
    add_column :access_tokens, :final, :boolean
  end
end
