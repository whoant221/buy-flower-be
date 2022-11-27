class RemoveNoteFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :note, :string
  end
end
