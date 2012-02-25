# -*- coding: UTF-8 -*-

module RubyPersistenceAPI

  # Base class for all exceptions raised by or wrapped by a backend
  class BackendError < StandardError; end

  # Generalizes ActiveRecord::RecordInvalid
  class ObjectInvalid < BackendError; end

  # Generalizes ActiveRecord::RecordNotFound
  class ObjectNotFound < BackendError; end

  # Generalizes ActiveRecord::Rollback
  class Rollback < BackendError; end

  class MissingPersistentAttributes < BackendError; end

end
