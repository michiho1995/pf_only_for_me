class AddColorToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :red, :integer, default: 0
    add_column :posts, :blue, :integer, default: 0
    add_column :posts, :green, :integer, default: 0
    add_column :posts, :pink, :integer, default: 0
    add_column :posts, :white, :integer, default: 0
    add_column :posts, :yellow, :integer, default: 0
    add_column :posts, :gold, :integer, default: 0
    add_column :posts, :silver, :integer, default: 0
    add_column :posts, :black, :integer, default: 0
    add_column :posts, :clear, :integer, default: 0
    add_column :posts, :brown, :integer, default: 0
    remove_column :posts, :color, :string
  end
end
