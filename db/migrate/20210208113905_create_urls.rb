class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :key
      t.text :source
      t.integer :clicked, default: 0

      t.timestamps
    end
  end
end
