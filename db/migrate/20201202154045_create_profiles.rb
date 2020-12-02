class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nik
      t.string :image
      t.string :nama
      t.string :telp

      t.timestamps
    end
  end
end
