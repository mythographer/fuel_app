class CreateCheckStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :check_statuses do |t|
      t.string :name, limit: 30, null: false, index: { unique: true }
      t.text :description, limit: 255

      t.timestamps
    end
  end
end
