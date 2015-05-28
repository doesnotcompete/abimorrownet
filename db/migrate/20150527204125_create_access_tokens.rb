class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.references :profile, index: true
      t.datetime :validUntil
      t.boolean :admin
      t.boolean :extended

      t.timestamps
    end
  end
end
