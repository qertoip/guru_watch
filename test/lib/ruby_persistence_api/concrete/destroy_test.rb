# -*- coding: UTF-8 -*-

require 'rpa_test_helper'

module RubyPersistenceAPI

  class DestroyTest < RubyPersistenceAPI::TestCase

    include Entities

    class FoNewObject < self
      test 'marks object as destroyed' do
        cat = Cat.new
        db[cat].destroy
        assert(cat.destroyed?)
      end

      test 'freezes the object' do
        cat = Cat.new
        db[cat].destroy
        assert(cat.frozen?)
      end
    end

    class ForPersistentObject < self
      test 'removes the object from persistent store' do
        cat = db[Cat].create!
        db[cat].destroy
        assert_raises(RubyPersistenceAPI::ObjectNotFound) do
          db[Cat].find(cat.id)
        end
      end

      test 'marks object as destroyed' do
        cat = db[Cat].create!
        db[cat].destroy
        assert(cat.destroyed?)
      end

      test 'freezes the object' do
        cat = db[Cat].create!
        db[cat].destroy
        assert(cat.frozen?)
      end
    end

  end

end
