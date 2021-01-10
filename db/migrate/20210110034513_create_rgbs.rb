class CreateRgbs < ActiveRecord::Migration[5.2]
  def change
    create_table :rgbs do |t|
      t.integer :red
      t.integer :green
      t.integer :blue
      t.integer :post_image_id

      t.timestamps
    end
  end
end
