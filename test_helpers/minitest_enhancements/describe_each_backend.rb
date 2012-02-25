class MiniTest::Spec

  def self.describe_each_backend
    backends = [RubyPersistenceAPI::ActiveMemory]
    backends.each do |backend_module|
      describe backend_module.name do
        yield( backend_module )
      end
    end
  end

end

class MiniTest::Unit::TestCase

  def self.backend_modules
    [::RubyPersistenceAPI::ActiveMemory, ::RubyPersistenceAPI::ActiveRecord]
  end

end
