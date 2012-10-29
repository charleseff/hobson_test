require 'hipchat-api'

module PostProcess
  class Notifier
    def initialize(test_run_id, hipchat_mention_name)
      @test_run_id          = test_run_id
      @hipchat_mention_name = hipchat_mention_name
    end

    def run
      hipchat.rooms_message(bot_room_id, 'Hobson', "@#{hipchat_mention_name}, your Hobson run is finished.  Go to #{test_run_url}", 1, 'yellow', 'text')
    end

    private
    def hipchat
      @hipchat ||= HipChat::API.new('e90fc81dc47cd1302f8870e94eafa4')
    end

    # not used yet:  if we can get the exactly hipchat user, we can use this to get the exact hipchat mention name:
    def hipchat_mention_name_bak
      user = hipchat.users_list['users'].find { |u| u['name'] == name }
      user['mention_name']
    end

    def hipchat_mention_name
      @hipchat_mention_name
    end

    def bot_room_id
      @bot_room_id ||= hipchat.rooms_list['rooms'].find { |r| r['xmpp_jid']== '14943_bot_stuff@conf.hipchat.com' }['room_id']
    end

    def test_run_url
      "#{hobson_web_url}/projects/change_production/test_runs/#{@test_run_id}"
    end

    def hobson_web_url
      "http://hobson.changeeng.org:5678"
    end

  end
end