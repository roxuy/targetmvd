class TargetMatcherService
  attr_reader :target

  def initialize(target)
    @target = target
  end

  def find_matches
    targets = search_targets(@target.radius, @target.latitude, @target.longitude,
                             @target.topic_id, @target.user)
    conversations = create_conversations(targets, @target)
    matched_users = targets.map(&:user).uniq
    { target: target, conversations: conversations, matched_users: matched_users }
  end

  def search_targets(radius, latitude, longitude, topic_id, current_user)
    Target.within(
      radius,
      origin: [
        latitude,
        longitude
      ]
    ).where(topic_id: topic_id).where.not(user_id: current_user)
  end

  def create_conversations(targets, target)
    targets.map do |t|
      Conversation.create(user1: target.user, user2: User.find(t.user.id), topic: target.topic)
    end
  end
end
