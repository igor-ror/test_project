class AddLockVersionToHabitats < ActiveRecord::Migration[7.1]
  def change
    add_column :habitats, :lock_version, :integer
  end
end
