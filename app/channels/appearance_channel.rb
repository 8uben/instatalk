class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    @redis = Redis.new
    @list_name = 'current_users_nicknames'

    stream_from 'appearance'

    @redis.rpush(@list_name, current_user.nickname)
    appear
  end

  def unsubscribed
    @redis.lrem(@list_name, 1, current_user.nickname)
    appear
  end

  def appear
    @users = nicknames_list
    broadcast
  end

  private

  def nicknames_list
    @redis.lrange(@list_name, 0, -1)
  end

  def broadcast
    ActionCable.server.broadcast('appearance', {users: @users})
  end
end
