class FishGrowerJob
  include Sidekiq::Job

  def perform(fish_id)
    fish     = Fish.find(fish_id)
    new_age  = fish.age + 1
    fish.age = new_age

    fish.save!
    puts "Fish #{fish_id} updated"
  end
end
