# should be run with local bundle.
# should be passed with 2 arguments:
#  - test_run_id
#  - hipchat_mention_name

require 'pathname'
require File.expand_path("../../lib/post_process/notifier", Pathname.new(__FILE__).realpath)

test_run_id, hipchat_mention_name = ARGV

PostProcess::Notifier.new(test_run_id, hipchat_mention_name).run
