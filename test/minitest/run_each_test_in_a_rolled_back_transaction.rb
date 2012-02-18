# Monkey patch to ensure each test is run in a rolled back transaction
class MiniTest::Spec

  def db
    GuruWatch.instance.config.backend
  end

  # Taken from here:
  # https://github.com/seattlerb/minitest/blob/master/lib/minitest/unit.rb#L925

  def run_with_transaction_rollback( *args )
    ret_value = nil

    db.transaction do
      ret_value = run_without_transaction_rollback( *args )
      raise Backends::Rollback
    end

    ret_value  # The result of run must be always returned for formatters to work correctly
  end

  alias_method_chain :run, :transaction_rollback

end
