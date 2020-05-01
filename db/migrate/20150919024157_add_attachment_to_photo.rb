class AddAttachmentToPhoto < ActiveRecord::Migration
  def up
    add_attachment :photos, :file
  end

  def down
    remove_attachment :photos, :file
  end
end
