module IsolationLevels
  class PhantomRead
    AGE = 20
  
    def call_read_commited
      age = AGE
  
      # Open additional terminal, copy age and add update_record method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two different ages, which is anomaly
      ActiveRecord::Base.transaction(isolation: :read_committed) do
        first_read_results_count = find_records_count(age)
        puts "First read records count = #{first_read_results_count}"
        sleep(10)
        second_read_results_count = find_records_count(age)
        puts "Second read records count = #{second_read_results_count}"
      end
    end
  
    def call_repeatable_read
      age = AGE
  
      # Open additional terminal, copy age and add update_record method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two different ages, which is anomaly
      ActiveRecord::Base.transaction(isolation: :repeatable_read) do
        first_read_results_count = find_records_count(age)
        puts "First read records count = #{first_read_results_count}"
        sleep(10)
        second_read_results_count = find_records_count(age)
        puts "Second read records count = #{second_read_results_count}"
      end
    end
  
    def call_serializable
      age = AGE
  
      # Open additional terminal, copy age and add update_record method to it. 
      # Then run #call method, and run uppdate_age method in second terminal
      # You receive two different ages, which is anomaly
      ActiveRecord::Base.transaction(isolation: :serializable) do
        first_read_results_count = find_records_count(age)
        puts "First read records count = #{first_read_results_count}"
        sleep(10)
        second_read_results_count = find_records_count(age)
        puts "Second read records count = #{second_read_results_count}"
      end
    end
  
    def find_records_count(age)
      Fish.where(age: age).count
    end
  
    def update_record(age)
      fish = Fish.where.not(age: age).first
  
      fish.age = age
  
      fish.save!
    end
  end
end
