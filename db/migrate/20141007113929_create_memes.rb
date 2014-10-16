class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.text :name
      t.boolean :funny
      t.text :description
      t.text :emoji_pattern

      t.timestamps
    end
  end
end
