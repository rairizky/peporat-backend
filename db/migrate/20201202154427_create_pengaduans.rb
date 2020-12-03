class CreatePengaduans < ActiveRecord::Migration[6.0]
  def change
    create_table :pengaduans do |t|
      t.string :title
      t.string :nik
      t.date :tgl_pengaduan
      t.string :image
      t.text :laporan
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
