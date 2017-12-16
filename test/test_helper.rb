# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(reporter_options)]
