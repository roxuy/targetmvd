json.target @response[:target], :id, :title, :longitude, :latitude, :radius, :topic_id
json.match_conversation @response[:conversations], :id, :topic_id
json.matched_user @response[:matched_users], :id, :email, :name, :nickname, :gender
