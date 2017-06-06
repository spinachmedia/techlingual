class CreateUrlMsts < ActiveRecord::Migration
  def change
    create_table :url_msts do |t|
      t.text :name
      t.text :domain
      t.text :url

      t.timestamps null: false
    end
  end
end
