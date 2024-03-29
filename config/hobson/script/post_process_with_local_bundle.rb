# should be run with local bundle.
# should be passed with 2 arguments:
#  - test_run_id
#  - hipchat_mention_name
#  - test run passed (true or false)

require 'pathname'
require File.expand_path("../../lib/post_process/notifier", Pathname.new(__FILE__).realpath)

test_run_id, hipchat_mention_name, test_passed = ARGV

PostProcess::Notifier.new(test_run_id, hipchat_mention_name, test_passed == 'true').run
