class AddWordCountToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :word_count, :integer
  end
end
