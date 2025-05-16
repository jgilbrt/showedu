class AddReceiverIdIndexToShowus < ActiveRecord::Migration[7.1]
  def change
    add_index :showus, :receiver_id
  end
end
