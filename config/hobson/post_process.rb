# per-user notifications:
test_run.logger.info("Sending per-user notifications")

require 'pathname'
require File.expand_path("../lib/post_process/caller", Pathname.new(__FILE__).realpath)

PostProcess::Caller.new(root, test_run).run

__END__
# for test:
struct = Struct.new(:id, :requestor, :requested_by_ci?) {
  def requested_by_ci?
    false
  end
}

PostProcess::Caller.new(Pathname.new(__FILE__).realpath + "../../..", struct.new(4, 'Charles Finkel', true)).run
