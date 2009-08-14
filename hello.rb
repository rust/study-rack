# -*- coding: utf-8 -*-
require 'rubygems'
require 'rack'

class HelloApp
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["こんにちは、ラックさん。"]]
  end
end
