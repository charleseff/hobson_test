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

      Open3.popen3(
        { "BUNDLE_GEMFILE" => (@root.join 'Gemfile').to_s },
        command
      ) do |i, output, error, t|
        @test_run.logger.info "Stdout: #{output.read.chomp}"
        @test_run.logger.info "Stderr: #{error.read.chomp}"
      end
    end

    private
    def to_at_mention(requestor)
      "#{requestor.gsub(' ', '')}"
    end

    def command
      cmd = "bundle exec ruby #{root.join("config/hobson/script/post_process_with_local_bundle.rb").to_s}"
      cmd += " #{@test_run.id} #{to_at_mention(@test_run.requestor)} #{@test_run.passed?.to_s}"
      cmd
    end
  end
end