require 'open3'

# just enough to call the post_process with local bundle
module PostProcess
  class Caller
    attr_reader :root, :test_run

    def initialize(root, test_run)
      @root     = root
      @test_run = test_run
    end

    def run
      @test_run.logger.info("Running post_process step with local_bundle")

      return if @test_run.requested_by_ci?

      debugger
      Open3.popen3(
        { "BUNDLE_GEMFILE" => (@root.join 'Gemfile').to_s },
        command
      ) do |i, o, e, t|
        output = o.read.chomp
        debugger; 1
        @test_run.logger.info output
      end

      debugger
    end

    private
    def to_at_mention(requestor)
      "#{requestor.gsub(' ', '')}"
    end

    def command
      cmd = "bundle exec ruby config/hobson/script/post_process_with_local_bundle.rb"
      cmd += " #{@test_run.id} #{to_at_mention(@test_run.requestor)}"
      cmd
    end
  end
end