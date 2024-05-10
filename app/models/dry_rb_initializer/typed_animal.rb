module DryRbInitializer
  class TypedAnimal
    extend Dry::Initializer

    attr_writer :name

    param :type, type: Dry::Types["strict.string"], default: proc { "Cat" }
    option :legs_count, Dry::Types["strict.integer"], default: proc { 4 }
    option :name, Dry::Types["strict.string"], default: proc { "Candy" }

    def description
      puts "This is a #{type}, it has #{legs_count} legs and its name is #{name}"
    end
  end
end