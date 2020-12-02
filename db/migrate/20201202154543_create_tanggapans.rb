class CreateTanggapans < ActiveRecord::Migration[6.0]
  def change
    create_table :tanggapans do |t|
      t.integer :pengaduan_id
      t.date :tgl_tanggapan
      t.text :pesan
      t.integer :user_id

      t.timestamps
    end
  end
end
