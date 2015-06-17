class AddNumberToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :number, :string
  end
end
