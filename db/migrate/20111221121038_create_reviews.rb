class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :name
      t.string :city
      t.text :comment
			t.boolean :show_on_frontpage

      t.timestamps
    end
  end
end
