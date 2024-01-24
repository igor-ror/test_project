module IsolationLevels
  class NonRepeatableRead
    ID = 100
  
    def call_read_commited
      id = ID
  
      # Open additional terminal, copy ID and uppdate_age method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two different ages, which is anomaly
      ActiveRecord::Base.transaction(isolation: :read_committed) do
        first_read_age = fetch_age(id)
        puts "First read age = #{first_read_age}"
        sleep(10)
        second_read_age = fetch_age(id)
        puts "Second read age = #{second_read_age}"
      end
    end
  
    def call_repeatable_read
      id = ID
  
      # Open additional terminal, copy ID and uppdate_age method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two similar ages, which is normal
      ActiveRecord::Base.transaction(isolation: :repeatable_read) do
        first_read_age = fetch_age(id)
        puts "First read age = #{first_read_age}"
        sleep(10)
        second_read_age = fetch_age(id)
        puts "Second read age = #{second_read_age}"
      end
    end
  
    def call_serializable
      id = ID
  
      # Open additional terminal, copy ID and uppdate_age method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two similar ages, which is normal
      ActiveRecord::Base.transaction(isolation: :serializable) do
        first_read_age = fetch_age(id)
        puts "First read age = #{first_read_age}"
        sleep(10)
        second_read_age = fetch_age(id)
        puts "Second read age = #{second_read_age}"
      end
    end
  
    private
  
    def fetch_age(id)
      Fish.find(id).age
    end
  
    def update_age(id)
      fish = Fish.find(id)
  
      fish.age = fish.age + 1
  
      fish.save!
    end
  end
end
