class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :title
      t.string :created_by
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
