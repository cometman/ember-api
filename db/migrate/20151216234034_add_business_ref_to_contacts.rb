class AddBusinessRefToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :business, index: true, foreign_key: true
  end
end
