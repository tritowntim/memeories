class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.text :name
      t.date :started_at
      t.boolean :emoji
      t.text :medium
      t.text :description

      t.timestamps
    end
  end
end
