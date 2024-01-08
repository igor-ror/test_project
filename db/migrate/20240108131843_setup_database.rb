class SetupDatabase < ActiveRecord::Migration[7.1]
  def change
    create_table :habitats do |t|
      t.string :name
      t.integer :max_deep
      t.integer :fish_count
      t.timestamps
    end
    
    create_table :fishes do |t|
      t.string :name
      t.integer :weight
      t.integer :age
      t.string :area
      t.belongs_to :habitat, index: true
      t.timestamps
    end

    add_index :fishes, [:name, :weight]
    add_index :fishes, :age
    add_index :fishes, :area
  end
end
