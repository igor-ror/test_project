class ChangeFishesToFish < ActiveRecord::Migration[7.1]
  def change
    rename_table :fishes, :fish
  end
end
