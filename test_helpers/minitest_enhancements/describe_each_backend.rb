class MiniTest::Spec

  def self.describe_each_backend
    backends = [Backends::Memory]
    backends.each do |backend_module|
      describe backend_module.name do
        yield( backend_module )
      end
    end
  end

end
