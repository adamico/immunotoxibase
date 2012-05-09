class AddChapteridToFamily < ActiveRecord::Migration
  def change
    add_column :families, :chapter_id, :integer
  end
end
