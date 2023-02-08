class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.references :company, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :city
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
