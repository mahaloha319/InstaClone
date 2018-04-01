class RenameComentColumnToPictures < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :coment, :comment
  end
end
