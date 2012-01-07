require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 10, :metrics => [:wall_time, :memory, :allocations, :cpu_time, :process_time, :gc_runs, :gc_time],
                           :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    get '/articles', :format => :json
  end
end
