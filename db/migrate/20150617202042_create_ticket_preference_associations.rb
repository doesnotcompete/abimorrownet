class CreateTicketPreferenceAssociations < ActiveRecord::Migration
  def change
    create_table :ticket_preference_associations do |t|
      t.references :ticket, index: true
      t.references :profile, index: true
      t.integer :priority
      t.boolean :accepted

      t.timestamps
    end
  end
end
