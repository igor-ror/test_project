class FillDatabase
  RECORDS_COUNT = 1_000_000
  FISH_NAMES = [
    "Carp",
    "Pike",
    "Koi",
    "Perch",
    "Roach",
    "Katfish"
  ]
  HABITAT_NAMES = [
    "Lake",
    "River",
    "Sea",
    "Ocean"
  ]

  def call
    ages          = (1..50).to_a
    weights       = (1..100).to_a
    deeps         = (1..1000).to_a
    fish_counts   = (1..10000).to_a
    habitats_data = []
    fish_data     = []

    RECORDS_COUNT.times do |num|
      habitat_name = HABITAT_NAMES.sample
      deep = deeps.sample
      fish_count = fish_counts.sample

      habitats_data << { name: habitat_name, max_deep: deep, fish_count: fish_count }
    end

    Habitat.insert_all(habitats_data)
    puts "Habitats created"

    Habitat.find_each do |habitat|
      age = ages.sample
      fish_name = FISH_NAMES.sample
      weigth = weights.sample

      fish_data << { name: fish_name, weight: weigth, age: age, area: habitat.name, habitat_id: habitat.id }
    end

    Fish.insert_all(fish_data)
  end
end
