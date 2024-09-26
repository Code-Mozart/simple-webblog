class CreateBlogs < ActiveRecord::Migration[7.2]
  def change
    create_table :blogs do |t|
      t.text :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
