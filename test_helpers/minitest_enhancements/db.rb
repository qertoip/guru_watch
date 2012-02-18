# -*- coding: UTF-8 -*-

class MiniTest::Spec

  def db
    GuruWatch.instance.config.backend
  end

end
