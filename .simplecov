SimpleCov.start do
  add_filter "/spec/decidim_dummy_app/"
  add_filter "bundle.js"
  add_filter "/vendor/"
  add_filter ".simplecov"
  add_filter "/spec/"
end

SimpleCov.merge_timeout 1800

if ENV["CI"]
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
