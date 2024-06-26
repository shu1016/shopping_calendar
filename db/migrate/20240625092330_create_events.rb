class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :user,       null: false, foreign_key: true
      t.string :title,          null: false
      t.text :content,          null: false
      t.date :start_time,       null: false
      t.date :end_time,         null: false
      t.timestamps
    end
  end
end
