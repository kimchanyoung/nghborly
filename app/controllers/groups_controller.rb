class GroupsController < ApplicationController
  def inquire
  end

  def reassign
    current_user.update({group_id: nil})
    redirect_to groups_assign_path
  end

  def assign
    user_input = params[:address]
    user_input.delete("apartment")
    group_id = find_group_id(user_input)

    user = current_user


    if group_id.nil?
      flash[:now] = "We couldn't find your building. Can you be more specific?"
      render :inquire
    else
      user.update({group_id: group_id})
      flash[:success] = "Welcome to #{user.group.name}"
      redirect_to group_path(user.group)
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
    @users = @group.users
  end

  private

  def find_group_id(address_hash)
    normalized_address_params = normalize_address_params(address_hash)

    if normalized_address_params.nil?
      nil
    else
      Group.find_or_create_by(normalized_address_params).id
    end
  end

  def normalize_address_params(address_hash)
    base_api_endpoint = URI("https://api.smartystreets.com/street-address")

    secrets = {'auth-id' =>  ENV['SMARTY_STREETS_AUTH_ID'], 'auth-token' => ENV['SMARTY_STREETS_AUTH_TOKEN']}

    query = secrets.merge(address_hash)

    base_api_endpoint.query = URI.encode_www_form(query)

    api_response = Net::HTTP.get_response(base_api_endpoint)

    results = JSON.parse(api_response.body)

    if results.empty?
      nil
    else
      clean_results(results.first["components"])
    end

  end

  def clean_results(hash)
    unnecessary_keys = %w(plus4_code delivery_point delivery_point_check_digit)

    unnecessary_keys.each { |key| hash.delete(key) }

    hash
  end
end
