module DryRbInitializer
  class Animal
    extend Dry::Initializer

    attr_writer :name

    param :type, default: proc { "Cat" }
    option :legs_count, default: proc { 4 }
    option :name, default: proc { "Candy" }

    def description
      puts "This is a #{type}, it has #{legs_count} legs and its name is #{name}"
    end
  end
end
