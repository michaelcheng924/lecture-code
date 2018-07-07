class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :patient_id
      t.string :doctor_id

      t.timestamps
    end
  end
end
