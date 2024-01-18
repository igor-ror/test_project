# to test pessimistik locks you need 2 terminals.
# Copy ID and update_same_fish & update_next_fish methods into second terminal

module Locks
  class PessimisticLock
    ID = 300
    DELAY = 20

    # In first terminal run command Locks::PessimisticLock.new.call_with_transaction
    # Then run update_next_fish & update_same_fish methods in second terminal
    # Method update_next_fish will be executed and done immideatelly because 
    # such lock works only for fish record with id = 300
    # Method update_same_fish will be executed only after method call_with_transaction is done
    def call_with_transaction
      ActiveRecord::Base.transaction do
        fish = Fish.lock.find(ID)

        puts "Fihs age = #{fish.reload.age}"
        puts "Lock enabled"
        sleep(DELAY)
        puts "After lock"
        puts "Fish age = #{fish.reload.age}"
      end
    end

    # In first terminal run command Locks::PessimisticLock.new.call_with_lock
    # Then run update_next_fish & update_same_fish methods in second terminal
    # Method update_next_fish will be executed and done immideatelly because 
    # such lock works only for fish record with id = 300
    # Method update_same_fish will be executed only after method call_with_transaction is done
    def call_with_lock
      fish = Fish.find(ID)

      fish.with_lock do
        puts "Fihs age = #{fish.reload.age}"
        puts "Lock enabled"
        sleep(DELAY)
        puts "After lock"
        puts "Fish age = #{fish.reload.age}"
      end
    end

    # In first terminal run command Locks::PessimisticLock.new.call_transaction_lock
    # Then run update_next_fish & update_same_fish methods in second terminal
    # Method update_next_fish will be executed and done immideatelly because 
    # such lock works only for fish record with id = 300
    # Method update_same_fish will be executed only after method call_with_transaction is done
    def call_transaction_lock!
      ActiveRecord::Base.transaction do
        fish = Fish.find(ID)

        fish.lock!
        puts "Fihs age = #{fish.reload.age}"
        puts "Lock enabled"
        sleep(DELAY)
        puts "After lock"
        puts "Fish age = #{fish.reload.age}"
      end
    end

    # In first terminal run command Locks::PessimisticLock.new.call_lock
    # Then run update_next_fish & update_same_fish methods in second terminal
    # Method update_next_fish will be executed and done immideatelly because 
    # such lock works only for fish record with id = 300
    # Method update_same_fish will be executed immideatelly because such lock! without transaction won't work
    def call_lock!
      fish = Fish.find(ID)

      fish.lock!
      puts "Fihs age = #{fish.reload.age}"
      puts "Lock enabled"
      sleep(DELAY)
      puts "After lock"
      puts "Fish age = #{fish.reload.age}"
    end

    def update_same_fish
      fish = Fish.find(ID)
      fish.age = fish.age + 1

      fish.save
    end

    def update_next_fish
      fish = Fish.find(ID + 1)
      fish.age = fish.age + 1

      fish.save
    end
  end
end
