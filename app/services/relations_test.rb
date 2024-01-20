class RelationsTest
  CARP_NAME = "Carp"
  PIKE_NAME = "Pike"
  LAKE_NAME = "Lake"
  DELAY     = 5

  def test_without_any_preloading
    # Try to fetch 10 fish without preloading their habitats and call habitats
    carps = Fish.where(name: CARP_NAME).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end

    # were created 1 request to fetch fish and 10 additional requests to fetch each fish habitat
    nil
  end
  
  def test_preload
    # Try to fetch 10 fish with preloading their habitats and call habitats
    pikes = Fish.where(name: PIKE_NAME).preload(:habitat).limit(10)

    pikes.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end

    # were created 1 request to fetch fish and 1 request to fetch all related habitats

    sleep(DELAY)

    # Try to fetch 10 fish with preload their habitats and additional condition on habitat records
    carps = Fish.where(name: CARP_NAME).preload(:habitat).where(habitat: { name: LAKE_NAME }).limit(10)
    # Will throw the PG::UndefinedTable error
  end

  def test_eager_load
    # Try to fetch 10 fish with eager_loading their habitats and call habitats
    pikes = Fish.where(name: PIKE_NAME).eager_load(:habitat).limit(10)

    pikes.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end

    # were created 1 request to fetch fish and all related habitats

    sleep(DELAY)

    # Try to fetch 10 fish with eager_load their habitats and additional condition on habitat records
    carps = Fish.where(name: CARP_NAME).eager_load(:habitat).where(habitat: { name: LAKE_NAME }).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # Won't throw the PG::UndefinedTable error, will create only 1 request to DB

    sleep(DELAY)
    # Try to fetch 10 fish with eager_load their habitats and additional condition on habitat records by SQL
    carps = Fish.where(name: CARP_NAME).eager_load(:habitat).where("habitats.name = ?", LAKE_NAME).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # Won't throw the PG::UndefinedTable error, will create only 1 request to DB
    nil
  end

  def test_includes
    # Try to fetch 10 fish with includes their habitats and call habitats
    pikes = Fish.where(name: PIKE_NAME).includes(:habitat).limit(10)

    pikes.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # were created 1 request to fetch fish and 1 request to fetch all related habitats (works like preload)
    sleep(DELAY)

    # Try to fetch 10 fish with includes their habitats and additional condition on habitat records
    carps = Fish.where(name: CARP_NAME).includes(:habitat).where(habitat: { name: LAKE_NAME }).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # Won't throw the PG::UndefinedTable error, will create only 1 request to DB (works like eager_load)
    sleep(DELAY)

    # Try to fetch 10 fish with includes their habitats and additional condition on habitat records by SQL
    carps = Fish.where(name: CARP_NAME).includes(:habitat).references(:habitat).where("habitats.name = ?", LAKE_NAME).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # Won't throw the PG::UndefinedTable error, will create only 1 request to DB (works like eager_load)

    sleep(DELAY)

    # Try to fetch 10 fish with includes their habitats and additional condition on habitat records by SQL
    carps = Fish.where(name: CARP_NAME).includes(:habitat).where("habitats.name = ?", LAKE_NAME).limit(10)

    carps.each do |fish|
      puts "Fish age = #{fish.age}"
      puts "Fish habitat max deep = #{fish.habitat.max_deep}"
    end
    # Will throw the PG::UndefinedTable error
  end
end
