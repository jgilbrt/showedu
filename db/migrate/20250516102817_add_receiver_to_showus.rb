class AddReceiverToShowus < ActiveRecord::Migration[7.1]
  def change
    add_column :showus, :receiver_id, :integer
  end
end
