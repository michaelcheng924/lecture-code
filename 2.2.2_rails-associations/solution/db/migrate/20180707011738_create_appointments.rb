class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.belongs_to :patient
      t.belongs_to :doctor

      t.timestamps
    end
  end
end
