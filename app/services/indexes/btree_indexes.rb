module Indexes
  class BtreeIndexes
    # Table fish covered by several Btree indexes:
    # Index on age field
    # Index on area field
    # Composite index on name and weight fieleds
    # Table habitats covered by one conditional index:
    # Index on max_deep field, only for records which max_depp > 500

    def call
      # Run each command and test how indexes work
      Fish.where(age: 20).explain
      Fish.where(area: "Lake").explain
      Fish.where(weight: 20).explain
      Fish.where(name: "Pike").explain
      Fish.where(name: "Pike", weight: 20).explain
      Fish.where(weight: 20, name: "Pike").explain
      Fish.where(age: 20, area: "Lake").explain
      Fish.where(area: "Lake", age: 20).explain
      Habitat.where(max_deep: 500).explain
      Habitat.where(max_deep: 501).explain
    end
  end
end
