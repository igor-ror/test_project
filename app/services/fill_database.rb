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
    ages = (1..50).to_a
    weights = (1..100).to_a
    deeps = (1..1000).to_a
    fish_counts = (1..10000).to_a

    RECORDS_COUNT.times do |num|
      fish_name = FISH_NAMES.sample
      habitat_name = HABITAT_NAMES.sample
      age = ages.sample
      weigth = weights.sample
      deep = deeps.sample
      fish_count = fish_counts.sample

      habitat = Habitat.create!(name: habitat_name, max_deep: deep, fish_count: fish_count)
      fish = Fish.create!(name: fish_name, weight: weigth, age: age, area: habitat_name, habitat_id: habitat.id)

      puts "#{num} fish created"
    end
  end
end
