# -*- coding: UTF-8 -*-

class MiniTest::Spec

  def db
    Application.instance.config.backend
  end

end
