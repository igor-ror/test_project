class AddConditionalIndexOnHabitatsMaxDeep < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_index :habitats, :max_deep, where: "max_deep > '500'", algorithm: :concurrently
  end
end
