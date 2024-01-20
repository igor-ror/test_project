# to test pessimistik locks you need 2 terminals.
# Copy ID and update_habitat_max_deep & update_habitat_fish_count methods into second terminal

module Locks
  class OptimisticLock
    ID    = 400
    DELAY = 20

    # In first terminal run command Locks::OptimisticLock.new.call_with_transaction
    # Then run update_habitat_max_deep & update_habitat_fish_count methods in second terminal
    # Method update_habitat_max_deep will trow an ActiveRecord::StaleObjectError after finish call_with_transaction method
    # Method update_habitat_fish_count will trow an ActiveRecord::StaleObjectError after finish call_with_transaction method
    def call_with_transaction
      ActiveRecord::Base.transaction do
        habitat = Habitat.find(ID)
        puts "Habitat max deep = #{habitat.max_deep}"
        habitat.max_deep += 1
        habitat.save!
        sleep(DELAY)
        puts "After delay habitat max deep = #{habitat.max_deep}"
      end
    end

    def call_without_transaction
      habitat = Habitat.find(ID)
      puts "Habitat max deep = #{habitat.max_deep}"
      habitat.max_deep += 1
      habitat.save!
      sleep(DELAY)
      puts "After delay habitat max deep = #{habitat.max_deep}"
    end

    def update_habitat_max_deep
      habitat = Habitat.find(ID)
      puts "Habitat max deep = #{habitat.max_deep}"
      habitat.max_deep += 1
      puts "Habitat max deep after update = #{habitat.max_deep}"

      habitat.save
    end

    def update_habitat_fish_count
      habitat = Habitat.find(ID)
      puts "Habitat fish_count = #{habitat.fish_count}"
      habitat.fish_count += 1
      puts "Habitat fish_count after update = #{habitat.fish_count}"

      habitat.save
    end
  end
end
