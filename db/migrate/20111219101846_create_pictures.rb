class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :position
      t.string :photo
      t.string :category

      t.timestamps
    end
  end
end
