module IsolationLevels
  class DirtyRead
    ID = 200
  
    # Copy ID constant and boths method into two separate terminals
    # run transaction_1 in first terminal, and after that run transaction_2 in second terminal
    # transaction_2 won't show the incorrect result because PostgreSQL have build in logic to prevent
    # DirtyRead anomany even on the :read_uncommitted isolation level
    # But this anomaly could happen in other DBMS (for example MySQL)
    def transaction_1
      ActiveRecord::Base.transaction(isolation: :read_uncommitted) do
        fish = Fish.find(ID)
  
        fish.age = 1000
  
        fish.save
        puts "Updated age of fish to 1000"
        sleep(10)
        raise StandardError.new("Test rollback")
      end
    end
  
    def transaction_2
      ActiveRecord::Base.transaction(isolation: :read_uncommitted) do
        age = Fish.find(ID).age
  
        puts "Fish age is #{age}"
      end
    end
  end
end
