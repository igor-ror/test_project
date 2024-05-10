module DryRbInitializer
  class TestService
    def test_simple_initializer
      # initialize animal with default values
      cat = DryRbInitializer::Animal.new

      cat.type # => Cat
      cat.name # => Candy
      cat.legs_count # => 4
      cat.description # => puts description
      cat.name = "My Candy" # can change the name
      cat.name = 1 # even on the number :(

      # init animal with custom fields
      snake = DryRbInitializer::Animal.new("Snake", legs_count: 0, name: "I hate snakes")

      snake.type # => Snake
      snake.name # => I hate snakes
      snake.legs_count # => 0
      snake.description
    end

    def test_typed_initializer
      # init animal with default values
      cat = DryRbInitializer::TypedAnimal.new

      cat.type # => Cat
      cat.name # => Candy
      cat.legs_count # => 4
      cat.description # => puts description
      cat.name = "My Candy" # can change the name on string
      cat.name = 1 # even on the number still :(

      # init animal with incorrect type of the field

      horse = DryRbInitializer::TypedAnimal.new("Horse", legs_count: 4, name: 4) # => raise Dry::Types::ConstraintError

    rescue Dry::Types::ConstraintError => e
      puts "Type error: #{e.message}"
    end
  end
end
