class CreatePengaduans < ActiveRecord::Migration[6.0]
  def change
    create_table :pengaduans do |t|
      t.date :tgl_pengaduan
      t.integer :user_id
      t.string :image
      t.text :laporan
      t.string :status

      t.timestamps
    end
  end
end
