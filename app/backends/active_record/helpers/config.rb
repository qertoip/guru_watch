# -*- coding: UTF-8 -*-

module Backends

  module ActiveRecord

    class Config

      def self.load( env )
        require 'yaml'
        require 'erb'
        config_path = "#{File.expand_path(File.dirname( __FILE__ ) + '/../../../../config/backends/active_record.yml')}"
        config_yaml = YAML::load(ERB.new(IO.read(config_path)).result)
        config_hash = config_yaml[env]
        config_hash
      end

    end

  end

end
