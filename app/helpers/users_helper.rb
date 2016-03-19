module UsersHelper
  def action_buttons(user)
    case current_user.friendship_status(user) when "friends"
      link_to "Remove Friendship", frienship_path(current_user.friendship_relation(user)), method: :delete
    when "pending"
      link_to "Cancel Request", frienship_path(current_user.friendship_relation(user)), method: :delete
    when "requested"
      link_to "Accept", accept_frienship_path(current_user.friendship_relation(user)), method: :put
    when "not_friends"
      link_to "Add as Friend", frienships_path(user_id: user.id), method: :post
    end
  end
end
