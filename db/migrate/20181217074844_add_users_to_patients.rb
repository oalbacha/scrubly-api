class AddUsersToPatients < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :provider, foreign_key: {to_table: :users, on_delete: :nullify }, null: true
  end
end
