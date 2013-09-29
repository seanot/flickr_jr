class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_name
      t.string :file
      t.integer :album_id

      t.timestamp
    end
  end
end
