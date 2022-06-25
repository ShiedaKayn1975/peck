class Api::V1::AuctionProductsController < Api::V1::ApiController
  def get_comments_history
    id = params['id']
    page = (params['page'] || 1).to_i
    perPage = (params['perPage'] || 10).to_i

    action_logs = ActionLog.order(created_at: :desc).where(state: 'finished', action_code: 'comment_auction', actionable_type: 'AuctionProduct', actionable_id: id).select(
      :id, :action_data, :action_code, :actor_id, :created_at, :action_label
    )
    count = action_logs.count(:id)
    action_logs = action_logs.limit(perPage).offset((page - 1)*perPage).as_json

    actor_ids = action_logs.map {|item| item['actor_id']}
    users = User.where(id: actor_ids, status: 'active').select(:id, :email).as_json.map {|item| [item['id'],item['email']] }.to_h

    action_logs = action_logs.map do |item|
      item['actor_email'] = users[item['actor_id']]
      item
    end

    return render json: {
      data: action_logs,
      count: count,
      page: page,
      perPage: perPage
    }
  end
end
